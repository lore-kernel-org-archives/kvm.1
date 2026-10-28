Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793151256;
	b=tLm+ZNle1N5umkLpWKBtwOoj1mMOJrvspHPdpIUQI5W5sv9cBRhGZWb06iZYvk3JVZ42
	 g/j0/drhR4O5P6ILY8fj3+H6Kf46nSSvmU0lAUC2JW+cMHJ6gVZsLedqJZ9H6U6UQ5Ref
	 LfJD+HoWmzBZOhy5QzoOyjUjeqXWEAkWQkk0eASVEvi+1OGuGsqID1lPo8xqadVifZORY
	 /3NiLwL8wE6FfL9bTlLUnUGzf9sns9fTKE37bIEVp/214ATEsJ/6e+l27r3/OcrLFd2Qi
	 qZ7wsI3gXZfj3jSlu/G8MTUMe84wdT1WgquRXBNS23FhSL9YgoT3IMY6d9O8KtGFCyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ceSvdvJb2kczIli1psGhGhGu/Eg5GANFV15HZPGtyK8=;
	b=LmRYrnyIXQQ36vp8V6zvoECmfZzbNdQ6FtGOK7t5aM514QJiUjFzN51uXj4V5lLWbRAx
	 sS4FU+GOJyoLNhI7VCwXOEZ0RHoRIEZgbRILoVrM83Q0Yagglp5f30ay6QKUwjbSYfY10
	 JcZfmNADoflHOVFoK3RSIqKoF0k8Y7q2HlNEiOfEUS5nxaImQP+f/wUuT5+y7rBGe0CR2
	 lh/oFcfZDPypaWq8yHndeBvEuhyojvcMaSfDfswc6N9ch/2eSKhS042ytyW0rgASAiKu7
	 yr3/LabkSXcIgFDHa7svvLl9xPh5ONamIH/5lcBNkooqjL6NzXTZT2TUAhcfiHGjdtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMYRoAci;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD7606A31F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 01:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BD7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMYRoAci
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f84a55cc06so264082a34.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793151255; cv=none;
        d=google.com; s=arc-20260327;
        b=A5ZJttS5xpcWB1C2ap4Iu/7n3fyhRUGrG/01zyihB2aVVuPktHr+TNGLiMGLOfdBcf
         X9U0KB+5K3EczrBTeRa1QOC/N1w8lfu3plWAtbiTvHNxkZiAU+ClXIBw379kLaJi6pdM
         Xmg6UIGdXN5zqap/gVnsN/s8xkIUHSxw/+jW9e06WXVlNtYm/kYilo3wLpEpeK8qtbNb
         Jr3n5Bj/+R93KSjCFSsdSGJhAbsOIsmHPY5f25Zgv674+9jqfgZlzN5XuvNXGycNxFAR
         TJ3lRnR5mTWaxlf0KckURNCHY+Fdv3ZJuBK3oLHiBVZKjP0/CQ6+QjVqqbHcPehkdX0S
         Jdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ceSvdvJb2kczIli1psGhGhGu/Eg5GANFV15HZPGtyK8=;
        fh=DeIX9ziinein0TJuLOTriryKACvtGFzY3E64os8b8dw=;
        b=Dthxz5P5fY9cNAk1znbIMluggsGjeLtIxIiQ4MIZ1bcVwqS7CzN+nkoNU+9UOquSDO
         hOCMeK/deI5UjdHWU/UhwFobINspGB6aLSm2FL7yptgomlde3IiB2b96WwrYlOSaf3hJ
         UusGM9EyzCDl3ILMRF+WUptgtofCfhKmRRVrfRgKICGV1yPUPwigVqvhtd/jA4wc2ppC
         erg1Cz1d6RfODU//ojpFBsKAZJazyAynpbgvYEINkTB8nNKcGeNT7wqtCYiiY/JhvxNq
         E18d24XycRKNDX3ksJbKH1ZLR0NEKATc0i6JsX6AC6EjgwH8E+FIM18XGjn5Q9gM+/ah
         JAzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793151255; x=1793756055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ceSvdvJb2kczIli1psGhGhGu/Eg5GANFV15HZPGtyK8=;
        b=mMYRoAcisf0Uv0owJKPukAKIfL7c12YS6OKkfoYZfyoMFNMJ7eus+7BpRGPiw9C8vm
         5cCW9xRrVnwU+eCNzfH/D0BReJ2IzJRuDUNb4KSItkCXM3p9a5sD1uP1/6YVKp/gY9sm
         CcFuNiKOdBy8qCkZ9A/sEaupaLvSAZw37UvLmz8Zp2CdVQR+m6ysMYXQxaOLYKuxRqpU
         b8U7O/SWvq0+aSizN3M1o1mc8Q8lmxPev18OUJTwipi4ETz/lV4HKifGwblo5gZ2Vtlw
         yuExrHRPgkcQErmw3S9LWeARnME6UhUboUm6iLfpqG9Ylo4aUJsMFXc7PopUyTKdSZGz
         ol6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793151255; x=1793756055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ceSvdvJb2kczIli1psGhGhGu/Eg5GANFV15HZPGtyK8=;
        b=yG73yEeLUDwEpboufxdJLZ7IONiq51qqtbYO8md0MXDnUmdFxSMMfVqf0Fp9sPxcHy
         7ur8pfaAI2w+gdBTMTNcxrRNwkTYWsR6nzfpQkhiThc5s6LFHGnZqLhl+nrjY5NfxZoN
         PAWxuXKWPKdhGUBcgU1kPwBiurVHR9EmcLFKEaddE6kPsFjwBPoJQiys6LqDwMw4Xt2b
         cvaBiXrxF3LsgaU2iRZiNsZID04MAjoIZbrEHPzR36bHn2bBc1qy4ULAp17ldEGZDpn1
         xU2V0pjd/uPfl1s2tCJrMfZzfh0/2cRJ5TYFvOoT58tHV2VLGuzXolnpQ+XOF+g2BXco
         w1WQ==
X-Gm-Message-State: AFq9FYKtmq4uypNr5gSObVf1cuGIEb0ByMH//dJPjDEbixu7QZ8jyHKL
	GpOvQQiv+TFBjWLTOaRC2q15YyfRMVD8omZBVjeDtOb3En0GFFInRMn4pOxwEgWSM4vMZV0Ft1R
	j5VS+gcGPnLBl7VMZB+r/gs594H2l6ciEZ00N
X-Gm-Gg: AYBFou1DBYdXAau2MxbQgJpL7Z2K+lXvPPNfYkithmKraBo08HqnCQmLKB2Igb6sAeD
	Ux77AfBpjrwJTM3XaBj3psH6Oye2l5DpabQmeOAiajYJhPUAxLr98D4TORdy6IZ8CsXDPmuo+MC
	ozLAI9lLE9J4tRy6zWPV9lGt67SAg783/vJIlKobK5+/umU5N78P3hXRUgeZPDRYNvVOAx/NZ/2
	cO6igbTjMqVylS1eUA/yKarXP+COZb3EqK9YRzhzfRs4DSV5lueK+SYfV8EZK2v70h39AYTo01v
	5xLYcGc6WovZR3HejMd9UvM7FhRg8Fdi+Yf7iIoZZbDuxps5/U223rwc0pTUusr0Rmqki0qUq9s
	wR0KM/2yUg7J01mF0Tr4A9orkIXb2USQdRq9kI3Y/6f2N2PmKl4wriFoA5gmVOCewenkZWAZFav
	e/O/voTP3Toqh7pWIjO2q4ISVpI4lIQbpDwGq9stiZuvRBd5mKeoQ3wM0S
X-Received: by 2002:a05:6808:168c:b0:4f4:6421:5efe with SMTP id
 5614622812f47-56383d93653mr590787b6e.36.1793151254639; Tue, 27 Oct 2026
 18:34:14 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CA+qxPTe6Dh7Yafw5zRJg1HxU61z7SvZuCOHDrpY2xe5X+M68iQ@mail.gmail.com>
 <auCrmeMslCWoiebJ@google.com>
In-Reply-To: <auCrmeMslCWoiebJ@google.com>
From: Sam H <sam.martin.howell@gmail.com>
Date: Wed, 28 Oct 2026 11:34:04 +1000
X-Gm-Features: AclHuK9hNjK1eEsKCfDoeAFGfQRcHRcRlQ8F8_4N7nX75WPfwG0zGXp8diphXug
Message-ID: <CA+qxPTfmTETd8Sr7Vfw8FrEpjybSiO6A0fjRbV6HBqW8aEorcA@mail.gmail.com>
Subject: Re: KVM: SVM: 32-bit PAE Windows 2000 guest crashes with AVIC on Zen
 2 (EPYC 7402), reproducible in seconds
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> I have a 32-bit Windows 2000 guest running the PAE kernel
>
> On purpose?  :-D

My face when I accidentally boot a Windows 2000 guest running the PAE
kernel again xD

Unfortunately, I inherited it. It's for a monolith app running on
servers older than I am. We are currently trying to strangler fig it
out of existence into microservices, but until the last vine closes in
it has to keep running. When they bought the replacement hypervisor
server, before I started, they didn't think (or know) to check for
things like this, so the old dying box with Intel CPU's works fine and
the new AMD one doesn't.

>> Host
>> - 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d
>
> Do you have access to Zen4+ hardware?  If this only reproduces on Rome (Zen2),
> then unfortunately the answer is going to be "don't run AVIC on Rome".

Yes, and it reproduces on Zen 4 as well.

I copied the same disk clone to a Zen 4 host and ran it with the same
QEMU arguments and the same stress load. It crashed twice out of two
valid runs.

Zen 4 host
- AMD Ryzen Threadripper 7960X (family 19h, model 0x18), 1 socket,
microcode 0xa10810c, CPU flags avic and x2avic
- Ubuntu 24.04, kernel 7.0.0-38.38~24.04.4-generic (based on 7.0.14)
- QEMU 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.18)
- kvm_amd: avic=Y, enable_ipiv=Y, vnmi=Y, npt=Y
- AVIC confirmed active during the runs with kvm tracing, not only
from the module parameter

Guest (same as the Rome runs)
- Same disk clone, booted on a throwaway qcow2 overlay each run
- Windows 2000 Datacenter Server SP4 kernel (5.00.2195.6717), boot.ini
/PAE /3GB, CR4 0x6b1 on all 8 vCPUs
- -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
8192 MiB, numa on
- -machine hpet=off -rtc driftfix=slew -global kvm-pit.lost_tick_policy=discard

Results
- AVIC on, /PAE /3GB: crashed within 28 s of starting the stress
  STOP 0x0000004E PFN_LIST_CORRUPT (0x00000099, 0x0, 0x0, 0x00000000)
- AVIC on, /PAE /3GB, repeat: crashed 10 s after starting the stress
  STOP 0x0000004E PFN_LIST_CORRUPT (0x00000099, 0x0, 0x1, 0x00000000)

The stop code is different from Rome (0x0A there), but the pattern is
the same. Parameter 1 0x99 is a PTE pointing at an invalid PFN, and
the PFN is 0. That fits a page table read coming back as zero, which
is what the 0x0A crashes on Rome showed. At the time of the crash 7 of
the 8 vCPUs were stopped at the same EIP (0xDD431D87), and the
crashing vCPU was at 0xDD069C0E doing port I/O to 0x1F0 while it wrote
the dump. The EIPs differ from my first mail because this clone is now
on the SP4 kernel and not Update Rollup 1.

Things that differ from the Rome host, for completeness: QEMU 8.2.2
here against 11.0.3 there, enable_ipiv=Y here against N there, and
x2AVIC and vNMI are available here.

What I do not have yet
- A clean AVIC off control on the Zen 4 host. My one attempt did not
finish booting the guest and I stopped it before any stress ran, so I
am not counting it. I will rerun it and follow up with the result.
- A reproducer I can share. The disk clone holds company data and
Windows 2000 is not mine to redistribute. A Debian 12 i386 guest on
the 686-pae kernel, same QEMU machine plus kvm=off -x2apic, under a
fork/exec/exit storm (about 21,600 forks/s across 8 vCPUs) ran for
about 4 minutes without a crash. That is a short run, so I would not
call it conclusive. Next I will try a clean Windows 2000 SP4 install
with the same QEMU arguments and boot.ini. If that crashes, I can send
the full steps to rebuild it from your own media plus the stress
script, which is ours.

In the meantime the offer stands. I can run any patch or debug build
against the clone on either host, and I can send vCPU register
captures and KVM traces from the Zen 4 crashes. The full memory dumps
contain company data, so I can't post those, but I can pull anything
specific out of them on request.

Thanks,
Sam Howell

On Tue, 27 Oct 2026 at 23:48, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Oct 27, 2026, Sam H wrote:
> > Hey KVM Team,
> >
> > I have a 32-bit Windows 2000 guest running the PAE kernel
>
> On purpose?  :-D
>
> > that bugchecks within 15 to 134 seconds under a process churn load on an AMD
> > Zen 2 host with AVIC enabled. The same guest survives the same load with AVIC
> > off, or with PAE off. I have a disk clone that reproduces it on demand and
> > can test patches against it.
> >
> > Host
> > - 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d
>
> Do you have access to Zen4+ hardware?  If this only reproduces on Rome (Zen2),
> then unfortunately the answer is going to be "don't run AVIC on Rome".
>
> > - Proxmox VE 9.2.21, kernel 7.0.14-25-pve, QEMU 11.0.3 (pve-qemu-kvm 11.0.3-4)
> > - kvm_amd: avic=Y, enable_ipiv=N, npt=Y
> > - Also crashes on 6.14.8-2-pve (no enable_ipiv parameter on that kernel)
> >
> > Guest
> > - Windows 2000 Datacenter Server SP4, boot.ini /PAE /3GB (ntkrpamp)
> > - Crashes on both the SP4 kernel (5.00.2195.6717) and the Update
> > Rollup 1 kernel (5.00.2195.7045)
> > - -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
> > 8192 MiB, numa on
> > - Extra args: -machine hpet=off -rtc driftfix=slew -global
> > kvm-pit.lost_tick_policy=discard (the PIT policy is what keeps AVIC
> > active for this guest)
> >
> > Crash
> > - STOP 0x0000000A IRQL_NOT_LESS_OR_EQUAL, IRQL 2, always in ntkrnlpa.exe.
> > - SP4 kernel: 0x0A (0x00000154, 2, 0, 0xDD537EAF), ntkrnlpa+0x137EAF,
> > mov ecx,[ebx+0x154] with ebx = 0 or 0xF000FF53 (the real mode IVT
> > pattern, i.e. the contents of guest physical page 0).
> > - UR1 kernel: 0x0A (0x00000098, 2, 0, 0xDD53C9E6), ntkrnlpa+0x13C9E6,
> > read of [esi+0x98] with esi = 0.
> > - One write variant was also seen: 0x0A (0x00000098, 2, 1, 0xDD53C84C).
> > - The faulting code is the PAE memory manager's hyperspace page table
> > walk: it maps a page table page into a per-CPU hyperspace slot by
> > writing a PTE, then reads through the slot, and the read comes back
> > zero.
> > - When it crashes, 7 of the 8 vCPUs are stopped at the same EIP
> > (0xDD4335C3) and the crashing vCPU is at 0xDD06A1A6.
> >
> > Reproducer
> > 6 concurrent sessions, each looping 200 short cmd.exe processes plus
> > one debug.exe, so heavy process create and exit.
> >
> > Results on the clone (stress started after boot, same disk each time;
> > 8 vCPU 2x4, kvm64, numa on, 8192 MiB unless stated)
> > - AVIC on, /PAE /3GB (baseline): crashed at 134 s
> > - AVIC on, /3GB only, no /PAE: survived 300 s
> > - AVIC on, /PAE /3GB, 3584 MiB (no RAM above 4 GB): crashed at 26 s
> > - AVIC on, /PAE without /3GB: crashed at 30 s
> > - AVIC on, /PAE /3GB, QEMU vapic=off: crashed at 26 s
> > - AVIC off (PIT reinject), /PAE /3GB: survived 600 s, twice
> > - AVIC on, /PAE /3GB, repeat with tracing: crashed at 15 s
> > - AVIC on, /PAE /3GB, 1 socket x 8 cores: crashed at 50 s
> > - AVIC on, no /PAE, 30 minute soak: survived 1800 s
> >
> > The production copy of the guest also crashed 3 times in one day on a
> > single vCPU with AVIC on (7.0.14-25, enable_ipiv=N), so one vCPU
> > lowers the rate but does not remove it. Setting the CPU vendor to
> > GenuineIntel made no difference. During a traced run the AVIC IRQ
> > window toggled about 1 to 2 times a second, so I do not think it is
> > the IRQ window inhibit issue.
> >
> > The same guest image ran on an Intel Xeon E5-2620 v4 host (Proxmox VE
> > 5.4, kernel 4.15) for years and has no crash dumps on its disk from
> > that time.
> >
> > What I have not tested: npt=0, because AVIC needs NPT, so npt=0 would
> > also turn AVIC off and could not tell the two apart from the AVIC off
> > run above. It would also be a host wide change on a host running ~70
> > other production workloads/guests, and we can't risk performance
> > impacts. Also kernels other than 6.14 and 7.0.
> >
> > A possibly relevant difference: AMD APM Vol 2 section 15.25.10 says
> > that under nested paging the guest's PAE PDPTEs are not loaded at MOV
> > CR3 the way they are natively or under Intel EPT. I have not proven
> > that is the mechanism, and the AVIC off result says interrupt delivery
> > or timing plays a part as well.
> >
> > I can provide the two minidumps, register captures of all vCPUs at the
> > moment of a crash, and KVM traces, and I can run any patch against the
> > clone.
> >
> > Thanks,
> > Sam Howell
> >
