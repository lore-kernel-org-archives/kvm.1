Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50ED34DB41
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406225; cv=none; b=G0ihSZ9asuyzRtcSM8U9lUkwxpuHAAU4UKj/dmgBcXA5RA1TDPLpjp6/6S4yexJbktmxMQ/ET4Rtt/IvqI8Yodajc3OH61hBjXVhCZ9a1Bnd3tmXDohZvLsQMgETvlEGQcJfiyxahU2M0dLJZ3L/4x4b8lu/Ow5CfppkR7rDSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406225; c=relaxed/simple;
	bh=6agNb7vIumjuyspfkXospS+YqgofH6pre2cUS1K+X7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC473dZH5oGqdGycWtnAfbAw7JylXsSkr04wQKBhucPjlK++YLNJAc7DNxPljN6El9jBxWy3yst1ZqKum2Pu6YKTeZJk9O4w8LJm1rlsw6KWmu65gDXdMoF/Vb2SlHogjPgcSzTPlIpJj0SkcWWZVPmSOms0ZDU7OYAzAjtmvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqp6E7on; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqp6E7on"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1849658eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406223; x=1791011023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riWdPmPaF6yCA+QpUvXi1H8TQEU17/hMGN1s+wRfSqw=;
        b=Uqp6E7ongFWC1LSMXYPC4huP2Mcu7jLSiHth+zFYXi0mh1tNfcAKMzYsoHtS8vpNvZ
         KwH/5SGHoLaKzUPylNDkllB7PMI09beRzMp/A0xiMDYTcVJO2hF8xf6dtV7Tdn8vce/r
         OMuF4YysQXhTEN8q49TIlALxUrEiTiVxcT+4+1j36Bazc/WEZBj2z236EbqqwkyC9zA8
         nsbyroxESZDuo1Ml0pOoDO423ISTAXWSjF5JMrtrJP/k3g0aVivzNK07GyulC6iDYcFJ
         H1RRjze3/nFtJEPOuqknH5ECi8OxpswDsIy8noEP+L27PryE2zLHFstaQiv8oAAz+6FN
         /Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406223; x=1791011023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riWdPmPaF6yCA+QpUvXi1H8TQEU17/hMGN1s+wRfSqw=;
        b=D1JvNA9uFifPJiy4iv52KPkCZEu37iXf2GIT+pfQOXWtcFS1s3JWKZI1ou0L+vEPRp
         8Z2KazJ2AR0MgtPAwu4Og9Tf5Pm4SMz38+n99bBVNZiK5kzo6a5CjPi+Drj57wQFR4yW
         H6UQVlXDEs4OuuHexvuHVjbaj3x9PUGT4rtDiBsYm/tjD9DC9Pz9WhEbtAR3GKLWevSg
         Fw7J0rrwbgLSArRH0Nf/JamvRAyn2wRv7wD5Jg9qIik7OhllQQqZr4Xda5qqHqWsv64T
         1OZgth+ohO75GSFIjGI34RH2J6MruZLAlBeZ2bETQgURGqPlatojLac1SeeuBQ7fCsmZ
         2yJg==
X-Forwarded-Encrypted: i=1; AKwUvByYC34qcTO1kVd464IlnTp0kXEa/OskfUU90sIn7RwHXvzYl4Po+eLvnooNd6vWJ5cMTKg=@vger.kernel.org
X-Gm-Message-State: AFuF++kvRhroeT1cnTN9bOhyA73HXdF+beVkRuhiQmKrfQEPre4RvkRG
	LLrjlIgGi5df285e35rH6YNRhTpVrEp8BlFUzzRInSJRx/VKCMNtTmmu
X-Gm-Gg: AYBFou3/e7Jnb/AbOOpLaAuge4YwoeOK0/Oqtu75qoGmbakJUgqxdPu3EPpEQhCHHxz
	XKi9Ritik4VCLpHOApG+uVmyGoRJBz9feWsJfNEfI5H0qcpUmmVrNR8aPfE3vZ5thP7ALdxEWO8
	3ngcURcMkwQ/4aLJl8S9MsCsvFEPhJO7wjAW5C6KbOhhL1pg24YY2+gL231dH6lMCVGzEzfCSpL
	Osn+Kejd87iZ6dH+WmfPq9lcz7/ZB1WMtkEWq3Ou9zuWfbvaEKju/9H1saYt6YFxw9ZbhsG10/R
	Aj654X0M2IeKZ1hC2h+FPV8yAWnbAtLgXkqUI4RjcW0HQUBzPwRZf/vgKgx4bqdAQqvlHIGxswD
	YVETVtDOQ7CMRYz0yApXhPSy1wpIEqX6jBHh8B5Q5B7dw4brWvKGAGJD2zlzipFFNgovbNzAt2q
	e/SlNKrwKL20KTDR8vHIqlNdUG59VGn3voTraRiYw/W/IJ0UeEXxDSOIP53A7xShXRkgZDk0q4N
	O+OIW7AzOP4b32MsFHJnxk7IRq+iDA=
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr2378558eec.31.1790406222673;
        Sat, 26 Sep 2026 00:03:42 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 40/55] meson: link shared objects into qemu-system
Date: Sat, 26 Sep 2026 15:00:39 +0800
Message-ID: <20260926070057.1234-41-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract common_ss, system_ss, and family-common objects into one
qemu-system binary. Only arm, aarch64, microblaze-softmmu are
listed; a new target must have arch_srcs equal to target_info_def
only (target-info-def.c). Config headers stay in arch_genh.

- Union non-TARGET_* keys with y taking precedence
- Reject leftover arch_srcs on participating targets
- Reject TARGET_* conditions on common_ss and system_ss
- Link SDL, install the binary, and apply Darwin entitlements

Adding a target that still has per-target sources fails meson, for
example:

  combined qemu-system leftover for :
  expected:
  target-info-def.c
  arch_srcs:
  target/microblaze/mmu.c
  target/microblaze/machine.c
  target-info-def.c

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index d5639a2d676..7ab5c7971a8 100644
--- a/meson.build
+++ b/meson.build
@@ -4288,15 +4288,30 @@ if host_os == 'darwin'
 endif
 
 traceable = []
+single_binary_target_info_objects = []
+single_binary_config = {}
+single_binary_bases = {}
+single_binary_deps = []
+single_binary_crates = []
+single_binary_available = false
+
+single_binary_supported_targets = [
+  'aarch64-softmmu',
+  'arm-softmmu',
+  'microblaze-softmmu',
+]
+
 emulators = {}
-target_info_def = files('target-info-def.c')
+target_info_def_src = 'target-info-def.c'
+target_info_def = files(target_info_def_src)
 target_info_def_objects = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
   target_base_arch = config_target['TARGET_BASE_ARCH']
-  arch_srcs = [config_target_h[target]]
+  arch_srcs = []
   arch_deps = []
+  arch_genh = [config_target_h[target]]
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
   ]
@@ -4322,7 +4337,7 @@ foreach target : target_dirs
     endif
 
     c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
-    arch_srcs += config_devices_h[target]
+    arch_genh += config_devices_h[target]
     link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
   else
     abi = config_target['TARGET_ABI_DIR']
@@ -4433,7 +4448,7 @@ foreach target : target_dirs
   endforeach
 
   lib = static_library('qemu-' + target,
-                 sources: arch_srcs + genh,
+                 sources: arch_srcs + arch_genh + genh,
                  dependencies: lib_deps,
                  objects: objects,
                  include_directories: target_inc,
@@ -4443,6 +4458,45 @@ foreach target : target_dirs
   target_info_def_objects += {target: lib.extract_objects(target_info_def)}
 
   if target.endswith('-softmmu')
+    if target in single_binary_supported_targets
+      arch_src_rels = []
+      foreach src : arch_srcs
+        arch_src_rels += fs.relative_to(src, meson.project_source_root())
+      endforeach
+      if arch_src_rels != [target_info_def_src]
+        error('combined qemu-system leftover for ' + target + ':\n'
+              + 'expected:\n' + target_info_def_src + '\n'
+              + 'arch_srcs:\n' + '\n'.join(arch_src_rels))
+      endif
+      single_target_config = {}
+      foreach k, v : config_target
+        if not k.startswith('TARGET_')
+          single_target_config += {k: v}
+          if k not in single_binary_config or v == 'y'
+            single_binary_config += {k: v}
+          endif
+        endif
+      endforeach
+      target_common_no_target = common_ss.apply(
+        single_target_config, strict: false)
+      if (target_common.sources() != target_common_no_target.sources() or
+          target_common.dependencies() != target_common_no_target.dependencies())
+        error('common_ss must not use TARGET_* conditions')
+      endif
+      target_system = system_ss.apply(config_target, strict: false)
+      target_system_no_target = system_ss.apply(
+        single_target_config, strict: false)
+      if (target_system.sources() != target_system_no_target.sources() or
+          target_system.dependencies() != target_system_no_target.dependencies())
+        error('system_ss must not use TARGET_* conditions')
+      endif
+      single_binary_target_info_objects += lib.extract_objects(target_info_def)
+      single_binary_bases += {target_base_arch: true}
+      single_binary_deps += arch_deps
+      single_binary_deps += target_stubs
+      single_binary_crates += main_rs
+      single_binary_available = true
+    endif
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
@@ -4524,6 +4578,95 @@ foreach target : target_dirs
   endforeach
 endforeach
 
+# Combined qemu-system: one apply + extract, same sources as
+# qemu-system-$target.
+#
+# common_ss / system_ss use single_binary_config, the non-TARGET_* union where
+# 'y' takes precedence.
+# Do not use when: 'TARGET_*' on these sets; those keys are dropped and the file
+# would vanish from qemu-system.
+#
+# Family common/system libs use config_base_arch_mak[base] (every target of that
+# TARGET_BASE_ARCH, including user-mode if enabled).
+#
+# Each qemu-* lib contributes target-info-def.c. Participating targets must have
+# arch_srcs equal to target_info_def only.
+if single_binary_available
+  single_binary_objects = []
+  target_common = common_ss.apply(single_binary_config, strict: false)
+  single_binary_objects += common_all.extract_objects(target_common.sources())
+  single_binary_deps += target_common.dependencies()
+
+  target_system = system_ss.apply(single_binary_config, strict: false)
+  single_binary_objects += libsystem.extract_objects(target_system.sources())
+  single_binary_deps += target_system.dependencies()
+
+  foreach base, _ : single_binary_bases
+    config_base = config_base_arch_mak[base]
+    if base in target_common_arch_libs
+      src = target_common_arch[base].apply(config_base, strict: false)
+      single_binary_objects += target_common_arch_libs[base].extract_objects(
+        src.sources())
+      single_binary_deps += src.dependencies()
+    endif
+    if base in target_common_system_arch_libs
+      src = target_common_system_arch[base].apply(config_base, strict: false)
+      single_binary_objects += target_common_system_arch_libs[base].extract_objects(
+        src.sources())
+      single_binary_deps += src.dependencies()
+    endif
+  endforeach
+  single_binary_objects += single_binary_target_info_objects
+
+  single_binary_link_args = emulator_link_args
+  single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
+  qemu_system_name = 'qemu-system'
+  if host_os == 'darwin'
+    qemu_system_name += '-unsigned'
+  endif
+  qemu_system = executable(qemu_system_name,
+                           sources: [single_binary_crates, files('system/main.c')],
+                           dependencies: single_binary_deps + [sdl],
+                           objects: single_binary_objects,
+                           link_depends: [block_syms, qemu_syms],
+                           link_args: single_binary_link_args,
+                           build_by_default: true,
+                           install: true)
+  if host_os == 'darwin'
+    icon = 'pc-bios/qemu.rsrc'
+    build_input = [qemu_system, files(icon)]
+    install_input = [
+      get_option('bindir') / qemu_system_name,
+      meson.current_source_dir() / icon
+    ]
+    if 'CONFIG_HVF' in single_binary_config
+      entitlements = 'accel/hvf/entitlements.plist'
+      build_input += files(entitlements)
+      install_input += meson.current_source_dir() / entitlements
+    endif
+    emulators += {'qemu-system': custom_target('qemu-system',
+                 input: build_input,
+                 output: 'qemu-system',
+                 build_by_default: true,
+                 command: [entitlement, '@OUTPUT@', '@INPUT@'])
+    }
+    meson.add_install_script(entitlement, '--install',
+                             get_option('bindir') / 'qemu-system',
+                             install_input)
+  else
+    emulators += {'qemu-system': qemu_system}
+  endif
+else
+  error_str = f'''qemu-system only support targets:
+@single_binary_supported_targets@
+
+use ./configure --target-list= to choose at least one of them'''
+  t = custom_target(command: ['sh', '-c', 'echo "' + error_str + '" && exit 1'],
+                    output: 'none',
+                    build_by_default: false)
+  alias_target('qemu-system', t)
+endif
+
 # Other build targets
 
 if get_option('plugins')
-- 
2.52.0.windows.1

