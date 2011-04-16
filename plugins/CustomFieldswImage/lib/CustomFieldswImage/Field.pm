package CustomFieldswImage::Field;

use strict;

sub _customfield_types {
    my $customfield_types = {
        # type_key => {
        #   label => ' ',
        #   order => 999,
        #   field_html => ''
        #   field_html_params => '',
        #   options_field => '',
        #   options_delimiter => '',
        #   default_value => '',
        #   column_def => ''
        # },
        'icheckbox' => {
            label => 'Checkbox with Image',
            field_html => q{
                <input type="hidden" name="<mt:var name="field_name" escape="html">_cb_beacon" value="1" />
                <input type="checkbox" name="<mt:var name="field_name" escape="html">" value="1" id="<mt:var name="field_id">"<mt:if name="field_value"> checked="checked"</mt:if> class="cb" /> <label class="hint" for="<mt:var name="field_id">"><mt:var name="description" escape="html"></label>
                <img src="<mt:var name="image_path"><mt:var name="field_name" escape="html">.gif" />
            },
            field_html_params => sub {
                my ($key, $tmpl_key, $tmpl_param) = @_;
                my $app = MT->instance();
                my $static_path = $app->config('StaticWebPath') || $app->config('CGIPath') .'mt-static/';
                my $plugin = MT->component("CustomFieldswImage");
                my $image_path = $plugin->get_config_value('path_of_images','system') || 'plugins/CustomFieldswImage/images/';
                if ($plugin->get_config_value('path_in_blog','system')) {
                    $image_path = $app->blog->site_url . $image_path;
                }
                else {
                    $image_path = $static_path . $image_path;
                }
                $tmpl_param->{image_path} = $image_path;
            },
            column_def => 'vinteger_idx',
            order => 900,
        },
        'iradio' => {
            label => 'Radio Buttons with Image',
            field_html => q{
                <ul class="custom-field-radio-list">
                <mt:loop name="option_loop">
                    <mt:var name="option" regex_replace="/:.*$/","" setvar="current_value">
                    <li>
                        <input type="radio" name="<mt:var name="field_name" escape="html">" value="<mt:var name="option" regex_replace="/:.*$/","" escape="html">" id="<mt:var name="field_id">_<mt:var name="__counter__"><mt:if name="field_value" eq="$current_value"> checked="checked"</mt:if> class="rb" />
                        <img src="<mt:var name="image_path"><mt:var name="option" regex_replace="/^.*:/","" escape="html">" />
                        <label for="<mt:var name="field_id">_<mt:var name="__counter__">">
                            <mt:var name="label" regex_replace="/:.*$/","" escape="html">
                        </label>
                    </li>
                </mt:loop>
                </ul>
            },
            options_field => q{
                <input type="text" name="options" value="<mt:var name="options" escape="html">" id="options" class="full-width" />
                <p class="hint"><__trans phrase="Please enter all allowable options for this field as a comma delimited list"></p>
            },
            field_html_params => sub {
                my ($key, $tmpl_key, $tmpl_param) = @_;
                my $app = MT->instance();
                my $static_path = $app->config('StaticWebPath') || $app->config('CGIPath') .'mt-static/';
                my $plugin = MT->component("CustomFieldswImage");
                my $image_path = $plugin->get_config_value('path_of_images','system') || 'plugins/CustomFieldswImage/images/';
                if ($plugin->get_config_value('path_in_blog','system')) {
                    $image_path = $app->blog->site_url . $image_path;
                }
                else {
                    $image_path = $static_path . $image_path;
                }
                $tmpl_param->{image_path} = $image_path;
            },
            options_delimiter => ',',
            column_def => 'vchar_idx',
            order => 900,
        },
    };
}

sub doLog {
    my ($msg) = @_; 
    return unless defined($msg);
    require MT::Log;
    my $log = MT::Log->new;
    $log->message($msg) ;
    $log->save or die $log->errstr;
}

1;