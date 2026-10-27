Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108891;
	b=kzLfxg01whtDUkS/wT6CUOj6nnf53u6nR27q8rzZyAIvnP66Jxape+NDrJTXrEVGKr5q
	 TnM+T97HfaJftzT2Lyi8W/EynA5AHwjD3KlZcmfn1W5CKYHkQWNpo1bfP2ravQ75eFBpz
	 fiVryL9RpvW/HCTj3rhAthQaFMtIr6fjNp/7+M56kYk9tAF1vifNTwMlw941oxAmnVTdb
	 0j0rfuL+b06YmS1NFA+UncBVgKqxupQkK6A5/RHtot7k9m0I9X4UiitOzmVW9J3myJ2wU
	 U0qbYKGsAgjv/5n+sBfosd3wtLDv5lw3VOdGo/8GDXhgyDYgzlZA9proGvbHa7ytkmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BBwZiXKHF9YFz+qznEV62lDf20kSNF1uPxa9vPHb1oY=;
	b=dhUscH+2taGu2OBlLzrHeWa2ZuqrSNj/7aAPuYgH7/4Cn9nQg0t7kSXIB4frulRKuQny
	 /zitoPR2sJrXVoazy/nFN81LzxhKxQQBboX3uxbIye++N//ScvODb+p0HGv90alYev/Gy
	 Upy5pmrJX1yI5Soig4lIuBPGHYPmPuRKqmnoCmh8tW0DVXbL8/v3XSWOQ5Zoruob/Kr6G
	 rDacsS52wy1VotGXDAxA8rt2L12AVuDZOgeW6ouvrqczCIWlfctC/eMxLcGqq0Bo0o3/W
	 JlfnGWmWI0pdV0nCZcFpimXzSgtNY1xI8PbsChWhUhC506cZL6n19MaIhdqlIRvQFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oy3N4lo7;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAC606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 13:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25EAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oy3N4lo7
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a079256596so3350040b3a.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793108890; x=1793713690; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BBwZiXKHF9YFz+qznEV62lDf20kSNF1uPxa9vPHb1oY=;
        b=oy3N4lo7GOvTlmWOxiya1yHZGPAsA3WrP1ktvtJzySM/z295mmIptrsfWWQIBTPKvf
         g3sjdkoTdJLvgem1doZ1COu/10+jddAp13ctL9NgUiYMn9g5R5H3/rx1cR3Uy3DG8t8/
         U9vqZ53UOKfzSUrPQqkWNulT5x+ldPcqD858PGsQP3bLYoIRTQaS3k6+3odNs7+jotPf
         C+4vpnLTecQF3gMN0HlEoUl6p+wm/bf3aIZlQGgtoKFRZhhOS1eG17uReVo84729nnBS
         jcEtvoc4BzDZC7Ew4Ag/ciAqV2s1H865/j22bvhWg3S5y2RXsrgfZn4wpC5pYGLOJjE9
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108890; x=1793713690;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBwZiXKHF9YFz+qznEV62lDf20kSNF1uPxa9vPHb1oY=;
        b=Uh3q1np8K70pRjlDuDDH+fSJFY+n4NBxJp1unBRBMaiPWYzX4DH+yHiaQze4m5VAgX
         JwoKUxtsfYwVUMhnL0OLvOnysC59w3iEUuX/3qPI0RWGBWpNPcmrJqfuOxrrmG/2WbtC
         lS5jCorfztBetwo3LpJjs+jyicnxjnOxoCauS7Yuet9qvjuuRb0I6kXgXEOaLrWaVdHb
         w1ZgYV8fUbctD+7CLNmOeygdhjEdp+kn/fg1yW5242ydobF0WIC4X3QKx2IeijDViEAS
         pQjz92d7vP5VTOCa6NizsL4pXKcWsKvu6hWQr0vDX0duSiQwM6cPLhZ5Yd4DitpXUFFq
         /GHw==
X-Gm-Message-State: AFq9FYKE7P/lykPYG5oyjSmaVj+f0dVbsJ1aJy/hDu1B3Adr4BWhyXoK
	dc3DmfwMJ0MPyJlFmJ2x7ISSruCwe5GV9BmVVLPTz6E7phHEai1GqdC8wnobRHBDPfhAr1M526D
	68g2H3w==
X-Received: from pfgt23.prod.google.com ([2002:a05:6a00:1397:b0:89e:e234:4723])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240d:b0:88b:9eca:951a
 with SMTP id d2e1a72fcca58-8a364e63374mr7775433b3a.1.1793108890264; Tue, 27
 Oct 2026 06:48:10 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:48:09 -0700
In-Reply-To: <CA+qxPTe6Dh7Yafw5zRJg1HxU61z7SvZuCOHDrpY2xe5X+M68iQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CA+qxPTe6Dh7Yafw5zRJg1HxU61z7SvZuCOHDrpY2xe5X+M68iQ@mail.gmail.com>
Message-ID: <auCrmeMslCWoiebJ@google.com>
Subject: Re: KVM: SVM: 32-bit PAE Windows 2000 guest crashes with AVIC on Zen
 2 (EPYC 7402), reproducible in seconds
From: Sean Christopherson <seanjc@google.com>
To: Sam H <sam.martin.howell@gmail.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Sam H wrote:
> Hey KVM Team,
> 
> I have a 32-bit Windows 2000 guest running the PAE kernel

On purpose?  :-D

> that bugchecks within 15 to 134 seconds under a process churn load on an AMD
> Zen 2 host with AVIC enabled. The same guest survives the same load with AVIC
> off, or with PAE off. I have a disk clone that reproduces it on demand and
> can test patches against it.
> 
> Host
> - 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d

Do you have access to Zen4+ hardware?  If this only reproduces on Rome (Zen2),
then unfortunately the answer is going to be "don't run AVIC on Rome".

> - Proxmox VE 9.2.21, kernel 7.0.14-25-pve, QEMU 11.0.3 (pve-qemu-kvm 11.0.3-4)
> - kvm_amd: avic=Y, enable_ipiv=N, npt=Y
> - Also crashes on 6.14.8-2-pve (no enable_ipiv parameter on that kernel)
> 
> Guest
> - Windows 2000 Datacenter Server SP4, boot.ini /PAE /3GB (ntkrpamp)
> - Crashes on both the SP4 kernel (5.00.2195.6717) and the Update
> Rollup 1 kernel (5.00.2195.7045)
> - -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
> 8192 MiB, numa on
> - Extra args: -machine hpet=off -rtc driftfix=slew -global
> kvm-pit.lost_tick_policy=discard (the PIT policy is what keeps AVIC
> active for this guest)
> 
> Crash
> - STOP 0x0000000A IRQL_NOT_LESS_OR_EQUAL, IRQL 2, always in ntkrnlpa.exe.
> - SP4 kernel: 0x0A (0x00000154, 2, 0, 0xDD537EAF), ntkrnlpa+0x137EAF,
> mov ecx,[ebx+0x154] with ebx = 0 or 0xF000FF53 (the real mode IVT
> pattern, i.e. the contents of guest physical page 0).
> - UR1 kernel: 0x0A (0x00000098, 2, 0, 0xDD53C9E6), ntkrnlpa+0x13C9E6,
> read of [esi+0x98] with esi = 0.
> - One write variant was also seen: 0x0A (0x00000098, 2, 1, 0xDD53C84C).
> - The faulting code is the PAE memory manager's hyperspace page table
> walk: it maps a page table page into a per-CPU hyperspace slot by
> writing a PTE, then reads through the slot, and the read comes back
> zero.
> - When it crashes, 7 of the 8 vCPUs are stopped at the same EIP
> (0xDD4335C3) and the crashing vCPU is at 0xDD06A1A6.
> 
> Reproducer
> 6 concurrent sessions, each looping 200 short cmd.exe processes plus
> one debug.exe, so heavy process create and exit.
> 
> Results on the clone (stress started after boot, same disk each time;
> 8 vCPU 2x4, kvm64, numa on, 8192 MiB unless stated)
> - AVIC on, /PAE /3GB (baseline): crashed at 134 s
> - AVIC on, /3GB only, no /PAE: survived 300 s
> - AVIC on, /PAE /3GB, 3584 MiB (no RAM above 4 GB): crashed at 26 s
> - AVIC on, /PAE without /3GB: crashed at 30 s
> - AVIC on, /PAE /3GB, QEMU vapic=off: crashed at 26 s
> - AVIC off (PIT reinject), /PAE /3GB: survived 600 s, twice
> - AVIC on, /PAE /3GB, repeat with tracing: crashed at 15 s
> - AVIC on, /PAE /3GB, 1 socket x 8 cores: crashed at 50 s
> - AVIC on, no /PAE, 30 minute soak: survived 1800 s
> 
> The production copy of the guest also crashed 3 times in one day on a
> single vCPU with AVIC on (7.0.14-25, enable_ipiv=N), so one vCPU
> lowers the rate but does not remove it. Setting the CPU vendor to
> GenuineIntel made no difference. During a traced run the AVIC IRQ
> window toggled about 1 to 2 times a second, so I do not think it is
> the IRQ window inhibit issue.
> 
> The same guest image ran on an Intel Xeon E5-2620 v4 host (Proxmox VE
> 5.4, kernel 4.15) for years and has no crash dumps on its disk from
> that time.
> 
> What I have not tested: npt=0, because AVIC needs NPT, so npt=0 would
> also turn AVIC off and could not tell the two apart from the AVIC off
> run above. It would also be a host wide change on a host running ~70
> other production workloads/guests, and we can't risk performance
> impacts. Also kernels other than 6.14 and 7.0.
> 
> A possibly relevant difference: AMD APM Vol 2 section 15.25.10 says
> that under nested paging the guest's PAE PDPTEs are not loaded at MOV
> CR3 the way they are natively or under Intel EPT. I have not proven
> that is the mechanism, and the AVIC off result says interrupt delivery
> or timing plays a part as well.
> 
> I can provide the two minidumps, register captures of all vCPUs at the
> moment of a crash, and KVM traces, and I can run any patch against the
> clone.
> 
> Thanks,
> Sam Howell
> 
