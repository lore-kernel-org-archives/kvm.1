Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346A477E43
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060312; cv=none; b=Z0NcdcNve2CNCryklqLTlMNs66XZfQTrKEKyfrEeIWR+ionBEl9hHogXVwMnUlt96uOjUqltZfSsH6UCke4Wx/7WFiQfMQFMkwBqWycr4DwEEnwoSiFFckcSc0s7Q9kuXxFIm6EyhcvtEcRv0HkapxT9TBXro0BXNR8Punsf5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060312; c=relaxed/simple;
	bh=FqCaRPdFgCc/to3y1/YRgTf4frnYwdgRGfmFaq8NqAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fko9FcrSjFS6jvLd7yeFt8mSzKk5DOs9yvX2xGH14oPCvvC7EYWk5bOD7C6YjqNuPTQ/wOTKNsJfUbBRcU+wCZAezdd29UN0msmq8ByPT/hr8SdpiuPyPTp6x0pofb21QfgRKo5RSYoxgEkDzvj3ZqPkgae1/eyfhsYF/mt3b6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2PoUS5I; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2PoUS5I"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d93a8149bso1429399a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060305; x=1775665105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oep0xPVTL/A3/itmiVgy18Jj282Zsdu9CLfS6+cGQQ=;
        b=S2PoUS5I6bwDonKmt8yv0vGCS+m6IaMU69PEW4iMBoOJjVvrzq1AILPBIJpB9ZcpiR
         Z+SLTJ6uJTgyejVS83tquvoC6umL25ntVoNsXQZ0JnN1bsaamge+tYhhhYFGh3bwSnJN
         gRWEHYKtXVI/vEEk8UYlJtCLXnWof6AW9LJ8oEot3qEyVpVIgQTaVhLsAx9UzgaGKTkB
         IUEeSY8fRtOZ7kAJ+8u5mUCxY9ycreCWvzoxatmhvjaAeJr8ZsVCuVI6S5VRr5ERsmgL
         b7MpwxPejWjEos74Pr2xg6L0ppKlf3chN51tXXNjGlSPinhHIDkNlNpkQNi6RpGsXtqp
         TNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060305; x=1775665105;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8oep0xPVTL/A3/itmiVgy18Jj282Zsdu9CLfS6+cGQQ=;
        b=YQ0FJ7luxDz7+gRbV42xR0CnzbcNj83louDAeJaHYkXdvmyKcnbrI9t/lf56b4d2wT
         JWbqXnHiCi6mISgQVIP+vHi2BdKpJqfs0fAw4C5H8YfAQ6zvoJzJtHqEJU2KY7wwjGjx
         qPHD0g6LRm+7KXLG2FfbMjg2TRfpYb5bSG0xF7HEuAusuXcbSHlTY9kmWwIBRKhn4Qca
         o1YyA3b3kB3p2qcDuknpFob1rWGDQiu21g89zvIY+cwNvmZx7skNOjX0zUWTt2g8kp+k
         BmJfIJlZ5V0Gu0RpyI6R1+2wR//BHbg1aD4jYe0TTCWae56A2E/jAhHPddvYpdWMUke1
         J4uw==
X-Forwarded-Encrypted: i=1; AJvYcCXucTWaHptSeWumioPP8X1Byd3HnRYGOxcf1TKTDW1Qq7pbK96zQy2jEbpcS2U8iVxR+mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8D6T9lmcmrAKvKszmy1fD5V89KT7VlANZvnUFOSnUdmOchmo
	+32kKFc/Eh20e6MWpI8HXN2vOBrkjkW3n0co9u+fUVUAFc1hyWneMP2j4UOcs9Uk+6IWXXfdf2n
	1HkhovQ==
X-Received: from pjbnp13.prod.google.com ([2002:a17:90b:4c4d:b0:35d:97d0:f6eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f0e:b0:35b:e4f0:f9b4
 with SMTP id 98e67ed59e1d1-35dc6f660e3mr3232235a91.10.1775060304380; Wed, 01
 Apr 2026 09:18:24 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:18:23 -0700
In-Reply-To: <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com> <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com> <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
 <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com>
Message-ID: <ac1FT4G_VpFHRIWl@google.com>
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2; smp>1
From: Sean Christopherson <seanjc@google.com>
To: Srikanth Aithal <sraithal@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026, Srikanth Aithal wrote:
> On 4/1/2026 6:23 PM, Tom Lendacky wrote:
> > On 4/1/26 06:24, Aithal, Srikanth wrote:
> > > Hello Tom,
> > >=20
> > >=20
> > > On 3/23/2026 6:40 PM, Tom Lendacky wrote:
> > > > On 3/20/26 11:08, Aithal, Srikanth wrote:
> > > > > Hello,
> > > > >=20
> > > > > I am hitting a failure when shutting down a SEV-ES guest (smp>1) =
on
> > > > > recent linux-next, and narrowed it down with bisection on the hos=
t
> > > > > kernel. The issue appears with more than one vCPU (e.g. -smp 2); =
with -
> > > > > smp 1 shutdown completes normally in my tests. The same guest shu=
tdown
> > > > > path works with an older host kernel (<next-20260304) and is also
> > > > > avoided with current QEMU master or by cherry-picking a specific =
QEMU
> > > > > commit onto v10.2.2.
> > > > >=20
> > > > > Environment:
> > > > > Host kernel: linux-next, tag next-20260319 [1] (also observed sta=
rting
> > > > > from next-20260304).
> > > > > Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue;=
 -smp 1
> > > > > does not in my testing.
> > > > > Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested =
QEMU
> > > > > master at 8e711856d763 [2].
> > > > >=20
> > > > > Details on issue:
> > > > >=20
> > > > > After SEV-ES guest shutdown , the serial log shows a register dum=
p
> > > > > (example below) .
> > > > >=20
> > > > > [=C2=A0 =C2=A012.613383] reboot: Power down^M
> > > > > EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00a00f11
> > > > > ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
> > > > > EIP=3D0000b004 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D1
> > > > > ES =3D0000 00000000 0000ffff 00009300
> > > > > CS =3Df000 00800000 0000ffff 00009b00
> > > > > SS =3D0000 00000000 0000ffff 00009300
> > > > > DS =3D0000 00000000 0000ffff 00009300
> > > > > FS =3D0000 00000000 0000ffff 00009300
> > > > > GS =3D0000 00000000 0000ffff 00009300
> > > > > LDT=3D0000 00000000 0000ffff 00008200
> > > > > TR =3D0000 00000000 0000ffff 00008b00
> > > > > GDT=3D=C2=A0 =C2=A0 =C2=A000000000 0000ffff
> > > > > IDT=3D=C2=A0 =C2=A0 =C2=A000000000 0000ffff
> > > > > CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
> > > > > DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000=
000
> > > > > DR3=3D0000000000000000
> > > > > DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
> > > > > EFER=3D0000000000000000
> > > > > Code=3Db0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b=
8 <0c> 5d
> > > > > c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70=
 e2 7d
> > > > > c6 ee 00 00
> > > > > -> Hangs here
> > > > >=20
> > > > > Host kernel bisect (with QEMU v10.2.2) led to:
> > > > >=20
> > > > > Good (no crash on guest shutdown):
> > > > > 32d76cdfa1222c88262da5b12e0b2bba444c96fa
> > > > > KVM: SVM: Move core EFER.SVME enablement to kernel (local build t=
agged
> > > > > 7.0.0-rc232d76cdfa1222 during testing.)
> > > > >=20
> > > > > Bad (crash reproduced):
> > > > > 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
> > > > > KVM: x86: Move bulk of emergency virtualization logic to virt sub=
system
> > > >=20
> > > > Any chance you have the enable_virt_at_load module option set to fa=
lse?
> > >=20
> > > No, it is set to Y.
> > > # cat /sys/module/kvm/parameters/enable_virt_at_load
> > > Y
> > >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > So the first bad commit in my host kernel bisect was 428afac5a8ea=
. The
> > > > > commit prior [32d76cdfa122] did not have this issue.
> > > > >=20
> > > > > Later I used QEMU master and with same linux-next next-20260319 a=
s host,
> > > > > it did not reproduce the shutdown issue .. that was using QEMU ma=
ster
> > > > > [2].
> > > > >=20
> > > > > QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (ta=
rget/
> > > > > i386: convert SEV-ES termination requests to guest panic events).
> > > > > Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
> > > > > avoided the shutdown crash in my setup.
> > > >=20
> > > > Well, if it is converting a guest termination request, that is stil=
l not
> > > > good. It should be a clean shutdown.
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Questions:
> > > > >=20
> > > > > KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expe=
cted
> > > > > here, or is there anything that should be adjusted or documented
> > > > > following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
> > > > > QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equiv=
alent
> > > > > handling of SEV-ES termination) be appropriate for users staying =
on
> > > > > stable QEMU while moving to newer host kernels?
> > > >=20
> > > > That wouldn't actually solve the issue, it is just a much more user
> > > > friendly error message. Is there a termination event in the host dm=
esg
> > > > log?
> > >=20
> > >=20
> > > The guest shutdown proceeds normally until:
> > > [ OK ] Reached target poweroff.target - System Power Off.
> > > [ 9.918849] reboot: Power down
> > >=20
> > > At that point the serial console freezes with the register dump below
> > > (EIP=3D0000b004, HLT=3D1, EFER=3D0, etc.).
> > >=20
> > > [=C2=A0 OK=C2=A0 ] Finished systemd-poweroff.service - System Power O=
ff.
> > > [=C2=A0 OK=C2=A0 ] Reached target poweroff.target - System Power Off.
> > > [=C2=A0=C2=A0 10.029330] reboot: Power down
> > > EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00a00f11
> > > ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
> > > EIP=3D0000b004 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D=
0 HLT=3D1
> > > ES =3D0000 00000000 0000ffff 00009300
> > > CS =3Df000 00800000 0000ffff 00009b00
> > > SS =3D0000 00000000 0000ffff 00009300
> > > DS =3D0000 00000000 0000ffff 00009300
> > > FS =3D0000 00000000 0000ffff 00009300
> > > GS =3D0000 00000000 0000ffff 00009300
> > > LDT=3D0000 00000000 0000ffff 00008200
> > > TR =3D0000 00000000 0000ffff 00008b00
> > > GDT=3D=C2=A0=C2=A0=C2=A0=C2=A0 00000000 0000ffff
> > > IDT=3D=C2=A0=C2=A0=C2=A0=C2=A0 00000000 0000ffff
> > > CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
> > > DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
> > > DR3=3D0000000000000000
> > > DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
> > > EFER=3D0000000000000000
> > > Code=3D98 59 0c db 72 6c 94 71 3d a6 36 32 49 a8 08 22 bd d7 8c bb <4=
c> 3c
> > > d9 bd 90 b5 2e a0 69 26 53 df aa 4c bb fe 5a d9 b6 ee 7b 45 02 2e cf =
d9
> > > 60 48 00 00
> > >=20
> > >=20
> > >=20
> > > QEMU does **not** exit on its own =E2=80=94 it appears stuck.
> > >=20
> > > Only after I press Ctrl+C do I see in host dmesg:
> > > kvm_amd: SEV-ES guest requested termination: 0x0:0x0
> >=20
> > So we would have to see what is triggering that termination request.

IIUC, the termination request only occurs after CTRL+C.  If that's correct,=
 it's
a red herring, and the real question is why a graceful shutdown hangs.

> > We can probably instrument a guest kernel to get some more info.
>=20
> Sure, I can apply any debug patch and provide the debug logs.
>=20
> Note: I'm heading out on PTO until next Wednesday (April 8th). I won't be
> able to gather additional debug logs until I return.
>=20
> >=20
> > >=20
> > > I also set `kvm_amd.dump_invalid_vmcb=3D1` before reproducing, but it
> > > produced no additional output.
> > >=20
> > > This issue is still present on latest linux-next next-20260331 [https=
://
> > > git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?
> > > h=3Dnext-20260331, tag name=C2=A0=C2=A0=C2=A0 next-20260331
> > > (e5da3eef8dadab4e98b228725ca8948edd9d601f)]
> >=20
> > Is it only with linux-next? Which would point to a kernel change vs a
> > Qemu change.
>=20
> Yes, it is specific to linux-next (starting from next-20260304, bisected =
to
> 428afac5a8ea "KVM: x86: Move bulk of emergency virtualization logic to vi=
rt
> subsystem").
>=20
> - With older host kernels (< next-20260304) + QEMU 10.2.2 =E2=86=92 clean=
 shutdown
> (no hang, no termination message, QEMU exits normally).
> - With linux-next (next-20260331) + QEMU 10.2.2 =E2=86=92 hang at the reg=
ister dump
> after "reboot: Power down"; only Ctrl+C triggers the "SEV-ES guest reques=
ted
> termination: 0x0:0x0" message.
> - With linux-next + QEMU master (or 10.2.2 + cherry-pick of 56d89db2cfd8)=
 =E2=86=92
> no hang (the termination is converted to a guest panic instead).

What guest kernel are you using?  Bisecting to that commit for just the *ho=
st*
kernel is baffling.  I could see it preventing KVM from loading or somethin=
g, but
it should be completely out of scope with respect to guest activity.

How are you initiating shutdown withing the guest?  What's the full QEMU co=
mmand
line?

Can you also provide the OVMF image?  E.g. in case the hang occurs in EFI r=
untime
services or something.

I want to get this sorted out before the merge window and so would prefer n=
ot to
delay root causing this by a week or more. =20
