Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88633C5DBD
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225604; cv=none; b=L9/UHHCycnqyjbRo9wHh0rLvTH0qvK54mVFMrdZOLijuAwR3K/hBSUGLR1R4MiweS+3J5O2F3I5ffZKCnxXSi2PE9gzuYTMeDVO2dfG0/lmEC3yzgZZn4j3360iKunpffjk1BuUQnkCDGHpAwbO8AE0pxDw/HHhcdor1QbnjX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225604; c=relaxed/simple;
	bh=dPswdWjam+zjdX9RcYUZTTw37DhdDVkfMplvy4FhMWA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvjOBlDlD9xjm3+HUzg36eB9xJ7v1jFGU53rBUyCqou9h0QAgreyFhpUn5VSHD6LnQ7h88DnHZkPxjGfOkT6vSLr7XEcd3oZw5g7LppL06I+5Ox1bLZtSGEiWzlP8t7asYV3hxmdwOSZa4idS09N2so/v+SEo09idLCqh5aYgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYmIf6vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYmIf6vc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8828DC4CEF7
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225603;
	bh=dPswdWjam+zjdX9RcYUZTTw37DhdDVkfMplvy4FhMWA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eYmIf6vcdZ86BS8bgh6aqXTEHBetWZdlOUrYslwtJ1GEtTy7QnrgoO76j2KcOWhlS
	 TngidjXhPCf70YbM2emapPd7rnHXW27i++MrilXBvja1BGDMkh2JOozdJpZZ+tAylz
	 WuIy1IGdIH2w6auIx9JCb9NoiVdWsnJSRbFF3z9mm2sSbFH95pJ2pq3H0IMZ13DuIv
	 DJ8hPJHf5fy0o2iMgHdgQwXVsfZBsmAlZUKJ0fCSTV+5PQ+jJM21QHh5tdTS3tp/7f
	 1m6DFAxeieOceIIeA+AqyPnPLmkWMm+TG/UOsVatMefa+D6E13rmtv9bRYZY5XgkYD
	 /Lxl6yas2hgKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 799F4C41612; Fri,  3 Apr 2026 14:13:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221249] kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel Core
 Ultra (Arch Linux)
Date: Fri, 03 Apr 2026 14:13:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: seanjc@google.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221249-28872-zlESrIqdMq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221249-28872@https.bugzilla.kernel.org/>
References: <bug-221249-28872@https.bugzilla.kernel.org/>
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

--- Comment #1 from Sean Christopherson (seanjc@google.com) ---
On Mon, Mar 16, 2026, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221249
>=20
>             Bug ID: 221249
>            Summary: kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel
>                     Core Ultra (Arch Linux)
>            Product: Virtualization
>            Version: unspecified
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: kvm
>           Assignee: virtualization_kvm@kernel-bugs.osdl.org
>           Reporter: thisisamirv@gmail.com
>         Regression: No
>=20
> Created attachment 309692
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D309692&action=3Dedit
> log
>=20
> I am observing the following kernel message on a Lenovo ThinkPad X9-14 Ge=
n 1
> running Arch Linux on an Intel CPU:
>=20
> kvm_amd: CPU 1 isn't AMD or Hygon
>=20
> # System information
>=20
> Kernel: 6.19.6-arch1-1
> Distribution: Arch Linux

...

>   kvm_amd: CPU 1 isn't AMD or Hygon
>=20
> * The system does not have an AMD CPU.
> * It appears the kvm_amd module may be probed or initialized briefly
>   even on Intel systems.

This is highly unlikely to be an upstream kernel bug.  The unwanted probing=
 is
most likely coming from elsewhere.  Given that the out-of-tree VirtualBox
driver
loads shortly after the failed kvm_amd.ko load, my guess is that vboxdrv is=
 the
culprit.=20

[    3.087169] kvm_amd: CPU 1 isn't AMD or Hygon
[    3.118021] vboxdrv: module uses symbol (cr4_read_shadow) from namespace
module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.118032] vboxdrv: module uses symbol (__flush_tlb_all) from namespace
module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.118063] vboxdrv: module uses symbol (cr4_update_irqsoff) from namesp=
ace
module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.124334] vboxdrv: Found 8 processor cores/threads
[    3.152502] rtR0InitNative: g_pLnxInitMm=3D000000000ba3e8e7
[    3.181635] vboxdrv: Found KVM hardware-virtualization symbols
[    3.181638] vboxdrv: TSC mode is Invariant, tentative frequency 33023857=
43
Hz
[    3.181641] vboxdrv: Successfully loaded version 7.2.6 r172322 (interface
0x00340002)

FWIW, attempting to load kvm_{amd,intel}.ko on the "wrong" CPU is benign ot=
her
than the error message.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
