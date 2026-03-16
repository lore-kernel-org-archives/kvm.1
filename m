Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AA359A76
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703333; cv=none; b=IZeN5m+OkKnHJE7ZOz3VoYjqMRlNhV1Z4gfHE/hXLVzuugB7rfns4Xpvx1cIAzGDpJKKbMQQBwzj4JjlwZ9IpW5TRLqqh22rao95AtIsij08JK59vjTfrfUC9sd99lGsXryz+U+Ude+QJ9RNRvmy6QAUdEDuv6f7Eg2Pxi0bv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703333; c=relaxed/simple;
	bh=CEjWHeP9t6F+RED7J2sesdCe21WJahWEu4eTXxQQZ7g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tgBJu6gQjqEcDFpJN2oZq7G26zSRFBhYmNEIe5NHU6X6iPe9AAuCdbSYEZQHuVnDxgf2VtFMT6mUFhDCuaMyRWla6h5OcOImy6+z2qeNQiK/TzUf/iHhnPG2SFTKPQwivrrP1nweHc187/LnW1n7aewVtY181Xmlrop6aup/rMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvtmGFMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvtmGFMY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE9DC19424
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703332;
	bh=CEjWHeP9t6F+RED7J2sesdCe21WJahWEu4eTXxQQZ7g=;
	h=From:To:Subject:Date:From;
	b=kvtmGFMYEkJTwUAiig4Botp6yXnSdVqxfcr9lOkITv2rUMaEMKXHgtatv5pG2i4ha
	 oZXuLPZM/bZop+nA7qiHf2naElVn8+wgBg4ntHWvCEVvXtrjCZSzEkjmJ6offdtkn3
	 Wb5FwhxW9INeAoEn03cA11Vl0e+wnk/VF1CzM5GUIThz06UEmTkArtmrzsKljzt4FH
	 IZIZjVLBiG/4lBPxwFHyizSWjeayFIAaR9y738LOA92xEkMZGEDnL9q2pA/6ma6Lny
	 J30Ik6keck3dtNgqsMHv3AB0YCH53ZeNBzk7yj8Q7LZI4nbJeg/mtLcHhnaefY0FJl
	 Bs400ALqfj1Ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CF10DC53BC7; Mon, 16 Mar 2026 23:22:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221249] New: kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel
 Core Ultra (Arch Linux)
Date: Mon, 16 Mar 2026 23:22:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thisisamirv@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221249-28872@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221249

            Bug ID: 221249
           Summary: kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel
                    Core Ultra (Arch Linux)
           Product: Virtualization
           Version: unspecified
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: kvm
          Assignee: virtualization_kvm@kernel-bugs.osdl.org
          Reporter: thisisamirv@gmail.com
        Regression: No

Created attachment 309692
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309692&action=3Dedit
log

I am observing the following kernel message on a Lenovo ThinkPad X9-14 Gen 1
running Arch Linux on an Intel CPU:

kvm_amd: CPU 1 isn't AMD or Hygon

# System information

Kernel: 6.19.6-arch1-1
Distribution: Arch Linux
Laptop model: Lenovo ThinkPad X9-14 Gen 1 (21QBS0KV00)
CPU: Intel Core Ultra 7 268V
Architecture: x86_64

# CPU information (lscpu)

Vendor ID: GenuineIntel
Model name: Intel(R) Core(TM) Ultra 7 268V
Virtualization: VT-x

# Loaded KVM modules

lsmod | grep kvm

kvm_intel             516096  1
kvm                  1462272  3 kvm_intel
irqbypass              16384  1 kvm

# Observations

* The system uses an Intel CPU (GenuineIntel).
* The Intel KVM module (kvm_intel) loads normally.
* However, during boot the following message appears:

  kvm_amd: CPU 1 isn't AMD or Hygon

* The system does not have an AMD CPU.
* It appears the kvm_amd module may be probed or initialized briefly
  even on Intel systems.

# Attachments

The following are attached:

* sudo dmesg
* lscpu
* lsmod
* sudo acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
