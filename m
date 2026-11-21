Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795282136;
	b=RcWRSMVBlYh16K95tjoxm1wuvuEYHmeT8wGnBieqrqv3s7GNTjLVOY67sf9d5n0jwmsj
	 zWz+dpJvTrW1zPzPl10nG315zVanLm75digLvN1OMqlm9937Eg6qBxXWFB/Rf61EBxGQh
	 5jXwDCfcfnXbkAk3zMk0bR35f/qJGWxKZzmbkk61uQoDXNdUlOSULJoEHZHx8QP0YkEhE
	 +s1cMmHtthPROiuP3ETH8d3vkmJlMpKlcXNUMwxuNl5WlU1U3lN+GF6tdsvuq7i7SZnxp
	 qeICD8bp0bc7COfbyF+Eg62MPR6iGV+kfvdufOBxj2G9KzKrrT69WtW98KFZhEZO31w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DCLA3o2NGcsUsCeKdpfpu0O9OUOc9q0N8lXAsyG+wTU=;
	b=Vl0UJmnKmyipLMcugP9oPrNuPO0jqOgdxvVqBY+BJ2Vnru/Qxl24e8XAFh5ZLNFG0kZg
	 J7juf/UUKeOov+7l5Fy75MFx/pK+f+yukogTY0zU7FLa1qnknHecDByRGw4nB1W1lDbaH
	 2azYDSNwWJ3Iil3xtlws/KQgt0O2fvPkLGEw/fvjzbkeQEIHgJGwvPVPEoh9JlCyCPusb
	 ZHPANOOUviL8f3C9iHvaHwxVJflL9J1zwHdItoHMoQuXZET2uMQ/dzfpZQ7Um2qrliem4
	 VLWA1XmgFsEGFre8nN+uuVYcxIVKUWLEsabtc2xp/fclWIR5v1YLuDCPi4MQXwDsV1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6ExzVG5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD2606A32C
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 17:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BD2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6ExzVG5
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3acdab5afe2so9338981fa.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 09:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795282134; cv=none;
        d=google.com; s=arc-20260327;
        b=sDp9TnpX1tYOK3SxkZsfwlrKUUTiW64G3OyuVAeGYIycqgeQ/zYysTFgpyi2oS9utM
         oocSkdcO+gmoeY33QC/v4sC0ky2GJ/Lil1JxskUJGs51e8YlZe1HfW4L9kUryGJtjx/U
         8uvQtBUlnszaUFqWVDNl2yNA9oGOOWdoLGc77/1lqJLTzdr19KrZGMG+D4F2zQ5X6CWr
         GII0L1EVQp0CCisV0TnsvhGtRS5T4m+EmZ5J+t4C0EU7iDghP6Yk+HhHiv9Boy7D5Z32
         DTltAOZDsEOmcHKq1SsNMwyRfieSbPvm2K9U1GqEXVSP2p1I+DhzCq7J+cdWgrNH9+F0
         IweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=DCLA3o2NGcsUsCeKdpfpu0O9OUOc9q0N8lXAsyG+wTU=;
        fh=icv7v3n4lRZPudG5fIqhhCSAjMwwsoewalCsQVGXsTw=;
        b=l7crGGj9RPp0K8sv3JN+Q+3vGn+UbZXejaMLhYu3ZbjX7ZKA2147Cm4ZAdq/vSEZQj
         V9vuIVHq6mnisyRjaCTA4SLEN/J6GogL2QajDCAEWVbU3SDrwI/qat8xX9WbHn7zynAb
         CsrbFD4X3zdYKodKENrNvuLaFd4es5i4Api+HLs3yTJqjXuIpUMIKIhxvFcuDk2cC28o
         pgiqzpIo6J+O5tatZSNnwVTdaaaITcrg5yt9f3Ph/oCRYB16zyQNjZAWdiSCAl+C8MbW
         K52MKXt+IGKGzsqzxXmlFBR79DRw+81QWLkLc1v88gXZtEtAqDDX7/mZZpOvo3WXOZYf
         PLvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282134; x=1795886934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCLA3o2NGcsUsCeKdpfpu0O9OUOc9q0N8lXAsyG+wTU=;
        b=T6ExzVG5mcuJck4DhhXHwFnq05jr1J+iXdpeMcOWYtX77NCIj8mZw4kbmdZxUlbHjV
         glzDxATmczYJkAR0bjDcTAUob7wuAdPocb+w5N4PDnhAuWUl53eu7IYBBFgjWbqgF1iD
         lQdXjfocflO6ysTPTzhtyypjTbASznp3WM1jN3o2WTEGyf/uNdCZ/RvFSjmNeXIjRhUS
         /zoV8ayJ27pbJcXQ3wVex5KttZLDtXEVzsvaLOmvy3Ij7ipqv0LnegzkLYPGQM7ghUua
         vumpFLTG4pgUp3e6WWmvl9URKRbHl37pixItPFX3y6DsJwdpDL3CQfYIta8WsgW0OrYB
         RKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282134; x=1795886934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DCLA3o2NGcsUsCeKdpfpu0O9OUOc9q0N8lXAsyG+wTU=;
        b=NrkFQW32bVRBKXbtA3wIgVRidBGWpd//PaIL14eM11RQR+e5oeY2wv6j456hgeAYBJ
         kqyZqPnrxezHbwmoMuW29HSlFz+fJIxWn6H389ZYoPDaV3TjXTF1Bbnfb5FQvSoQX77V
         gLfrX7VXrUu6uBhxd8LhEFMRT3d4dycGKHSNy9JXlhO9Xeg1Dk4a4/irMQQ4AQ3xWe7T
         kEm5t5NhQa7tg1p4DA+4HFGxvkCdCBaGDEb1Vae90849/FmBtWXGDt9FBBurT/ORiaQ2
         IERTjh/RoKX/ewBTARHIw4ESOu91VqQhpy1Bb2zv8Fn8CR6mvGnkSIp3B07uji6nzUjF
         z7/w==
X-Forwarded-Encrypted: i=1; AL+hErECYtk/3vt2bZmUqvZ66ZGgVtKVZZ0cvVDytiymCS7GoSg+evl/NGG3+DDmNVMDIkl519s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UOndOoClvGS0c5GzLjwRUR+ApLPwB9fMUf0JwYeaaH+gGzspV
	FjmSaCvHMeC3Rn1GaDEQ343qd2OnS6zZWp9gT/ZWiE6DqRbMTx0NAj6speNcLYy1lOSombQUXMO
	LU/u2HFqsOP/u/FvuBHVcsojxEmqtT5c=
X-Gm-Gg: AZFdTZed4QRi6ctwwRb4bd8wtd/HS2oNAtw7/woAk1nFJrGRWiY99VwpUeAMidAZp6Z
	xOvLLXXEquqNlTUrlQW9RQCdCO4UN1oJihr/4L/GVamOno7cgxEGApqg42A7AmUe6K0RYqITlP8
	4W6j0Fs9FsIExBIF8EtaIhKngZ3ck61zdbzoWwOhbO74R0lcEKILUqE6t2x3HiqrEU+dZTl7ATq
	nv9KC09HUOfJb30RaxvIny2LIHJpXmUIorIqcylt7+/3LrUIumcOKholwpxv3Bp3OWFWRV6Cfzc
	DewIlyClGPexPQ1S+A6GdYwaO/FlbpUi28zDV0mp/HbnrrHOr2zfDOotrDM7V+cxJq2HahpU+Aa
	+Zm1Dx7Cg8tVcB1ZdKZ7eMOqH0d1Ytegaj9H/ZdXKOkmI+H8elQ/1Xkx0jQitpcTIG8U=
X-Received: by 2002:a05:651c:419b:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3ae7fa3ac6fmr17559001fa.22.1795282134270; Sat, 21 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Sun, 22 Nov 2026 01:28:39 +0800
X-Gm-Features: Aa3M54plDJziP3_T6TamE_LALOBZqkSmXnp5uvjP_CU0mpq17_H4ujLNSncIBDs
Message-ID: <CAO-4RZ3VRVmg-8wrej_cs5fopaEjKLtusEAyah9G4y+XLcWj4Q@mail.gmail.com>
Subject: [BUG] WARNING in __kvm_gpc_refresh (virt/kvm/pfncache.c:267, v7.4-rc3)
To: pbonzini@redhat.com
Cc: seanjc@google.com, dwmw@amazon.co.uk, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Sean, David,

We found a reproducible warning on v7.4-rc3 with syzkaller: the KVM guest
page cache invariant "either gpa or uhva must be valid, but not both" is
violated while KVM emulates a Xen event-channel send.  The supplied
recipe reproduced on independent fresh VMs; no state snapshot is
required.

Repository and reproducer:

  https://github.com/Zheng-zheng-codes/kvm-gpc-refresh-warning
  commit f9bb1f09b4070e6b19fdc49a10297b2afe7e5fb8

Report
------

  kvm_is_error_gpa(gpa) =3D=3D kvm_is_error_hva(uhva)
  WARNING: arch/x86/kvm/../../../virt/kvm/pfncache.c:267 at
__kvm_gpc_refresh+0x1692/0x1e40
  RIP: 0010:__kvm_gpc_refresh+0x1692/0x1e40 virt/kvm/pfncache.c:267
  Call Trace:
   kvm_gpc_refresh+0xed/0x160 virt/kvm/pfncache.c:382
   kvm_xen_set_evtchn.part.0+0x1b3/0x280 arch/x86/kvm/xen.c:2014
   kvm_xen_set_evtchn arch/x86/kvm/xen.c:2115 [inline]
   kvm_xen_hvm_evtchn_send+0x22f/0x290 arch/x86/kvm/xen.c:2105

The warning site:

  /* Either gpa or uhva must be valid, but not both */
  if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) =3D=3D kvm_is_error_hva(uhva)))
          return -EINVAL;

kvm_xen_set_evtchn() retries kvm_xen_set_evtchn_fast(), and on
-EWOULDBLOCK calls kvm_gpc_refresh(&kvm->arch.xen.shinfo_cache,
PAGE_SIZE), which re-refreshes the gpc with whatever gpa/uhva state the
cache currently holds.  In the failing run both representations were in
the same error state, so the refresh warned and returned -EINVAL and the
event-channel write failed.  The setup was a nested-KVM guest fuzzing the
KVM ioctls, including Xen HVM shared-info/event-channel configuration.

No memory corruption was observed; the effect is the WARN plus the failed
evtchn delivery.

Reproduction
------------

  git clone https://github.com/Zheng-zheng-codes/kvm-gpc-refresh-warning
  cd kvm-gpc-refresh-warning

  # boot v7.4-rc3 with the supplied kernel config
  # using a Debian trixie x86_64 guest

  # in the guest, as root:
  syz-execprog -procs=3D1 -threaded -repeat=3D1 \
      -executor ./syz-executor \
      reproducer/repro.kernsight.prog

The recipe is a state-reconstruction sequence (74 replay programs
followed by the crashing testcase).  The warning depends on the kernel
state built by the recipe; the testcase alone is not sufficient.  The
recipe must run with -procs=3D1; using -procs=3D8 did not reproduce the
warning under our tests.

Expected result: within about two minutes of starting the reproducer the
guest console shows

  kvm_is_error_gpa(gpa) =3D=3D kvm_is_error_hva(uhva)
  WARNING: arch/x86/kvm/../../../virt/kvm/pfncache.c:267 at
__kvm_gpc_refresh+0x1692/0x1e40

and the event-channel write that triggered it fails.  All five of our
fresh-VM verification runs hit this at 120-121 seconds.

Verification:

- pipeline auto-repro: attempt 1 triggered (160 replay programs) but was
  not verified within the 20-minute budget; attempt 2 verified
  (confirmed=3Dtrue, status=3Dverified, fresh-VM recipe replay, 74 replay
  programs, 2026-11-21T14:59:08Z)
- stability on fresh VMs: five independent runs, 5/5 reproductions,
  120-121 s to the warning in every run (2026-11-21, external-verify/)
- C reproducer: not generated; the syzkaller recipe is the primary
  reproducer

Repository contents
-------------------

  README.md               overview, analysis and verification table
  environment.txt         kernel/guest hashes and exact QEMU command line
  kernel.config           kernel configuration used for the reproduction
  description             original crash title
  SHA256SUMS              SHA-256 checksums covering every file in the
repository
                        (including the five verification runs and
their HIT markers)
  logs/                   original crash evidence
    log0 =E2=80=94 fuzzer log of the verified attempt
    machineInfo0 =E2=80=94 VM/environment record
    report0 =E2=80=94 crash report of the verified attempt
    title-stat =E2=80=94 occurrence statistics
  reproducer/             the reproducer and its provenance
    repro.kernsight.prog =E2=80=94 the reproducer: 74 replay programs follo=
wed
by the crashing testcase (log format)
    repro.prog =E2=80=94 the crashing testcase alone (not sufficient)
    repro.priming.prog =E2=80=94 the replay/priming prefix
    repro.priming.json =E2=80=94 priming trace (candidate picks, distances)
    repro.context.json =E2=80=94 reproduction context (fresh_vm_recipe_repl=
ay)
    repro.state.json =E2=80=94 measured 539-D pre-crash state vector
    repro.report =E2=80=94 raw crash report of the reproduction
    repro.stats =E2=80=94 phase/timing log of the reproduction
    repro.README.txt =E2=80=94 original bundle description
  external-verify/        five independent fresh-VM verification runs
    README.md             methodology and per-run results
    run-1 ... run-5/
      serial.log =E2=80=94 full guest console of the run
      run.log =E2=80=94 harness log with hashes and timings
      HIT =E2=80=94 marker written when the target appeared

Kernel/guest details:

  kernel: v7.4-rc3, bzImage sha256
    0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
  guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM, nested KVM
  boot: oops=3Dpanic panic_on_warn=3D1 hung_task_panic=3D0 kvm-intel.nested=
=3D1
  config: CONFIG_KASAN=3Dy, CONFIG_PROVE_LOCKING=3Dy, CONFIG_KVM=3Dy,
    CONFIG_KVM_XEN=3Dy

Thanks,
Zheng
