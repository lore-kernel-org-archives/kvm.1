Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643928;
	b=N7xmbvTVEhJBiA0Atl+uqOx2fF8O5+QnS3j7VKbWOjPZig6ZDCH+BqyzabHnPJyOA9U9
	 lLppPuRWt5/Xs6ijHHQssoFlYlgbs9YzgjhX5aP0n0T/2HasARcW8+s1bOE/s1m3KLo81
	 OYJAxxOcyimutMwYq13TCQ7UiEaYrG5/AG53IGCxA7YxL7XxkUYrfWdJ+OleZTyPPolvz
	 XhYYCUH1pYCX8yG89p3wtfD0PA/M8EAHLiF4gOtC/xVS07CMUA0zwEK9cZslv7MzELYWJ
	 vt3BUoMCkCXrMIE2/CV6cknj99AbSyg169aPJhtfzxg96FICQzu41+LosJkaqz8apmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643928;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j7pHsCqaqyqWpLQA4VpkVcNk0Xrxk81x9TDCYFBxSF8=;
	b=k02MAC1NODUgPJiUxJbg3MU1LKa4bc+IOJomU1aX2scahyn60pJ/XljQoCeeMBOLyyW5
	 ntS9491ajropvIrKEx5d9+uTMmDBBwQqQppdp60k0F1pv8908AYhiu25lqRLfCeK1q8vO
	 jf4PladkDS1WpNoSWuM9HeqZo3npb7TQvSh+V3T1U2ppthi3O7p7GFjfOnl5BRzT/YruS
	 PqpncbLSnQ6VLvNqcBznjJiL0lnRKOzzpFCkarL2Ind2fyjq7UmN3vDZMqdvo4wUdAYWV
	 cs14nmCpYxhp+/6CMKEJ8O0StvIEZgOFfohw15LR0aSaL/Jmd9/IupbdaTCvSpwxkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqgLNhDS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2C606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqgLNhDS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15361F00A17;
	Mon,  2 Nov 2026 18:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643927;
	bh=j7pHsCqaqyqWpLQA4VpkVcNk0Xrxk81x9TDCYFBxSF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XqgLNhDS5qr3aixeo+Z0ednB2OZDgQ2mluXCvzlFjutf8uBXLWntA/vfVqFQIn11m
	 NALJvryxBx7+8E4AIidSDy4zTbdoMfJFBK+MMqcOkL81vMZ96nNfF7FbBhkxVnpP1F
	 S8KoqtrwhdLgV7GBUR339dSiCKMrBNTGsxK1RzC1fC1crdRpx86QSS9FhOU8lCapFx
	 l3tQR06nK4klBiidHyRD98i7DrULTdZKVeqezKqBpjExrrgPRqJ+F+OVSIVrQeZye0
	 l3i2TGc2kfF5Ca+Ilx6dyBJNSp0Nm+6jI464ChzbG6hgUezRPVTR7IAkCkV8evwhSc
	 uzjOBSDLbz9yA==
Date: Mon, 2 Nov 2026 23:53:40 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sam H <sam.martin.howell@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: KVM: SVM: 32-bit PAE Windows 2000 guest crashes with AVIC on Zen
 2 (EPYC 7402), reproducible in seconds
Message-ID: <aujQ9b3687Etdple@blrnaveerao1>
References: <CA+qxPTe6Dh7Yafw5zRJg1HxU61z7SvZuCOHDrpY2xe5X+M68iQ@mail.gmail.com>
 <auCrmeMslCWoiebJ@google.com>
 <CA+qxPTfmTETd8Sr7Vfw8FrEpjybSiO6A0fjRbV6HBqW8aEorcA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+qxPTfmTETd8Sr7Vfw8FrEpjybSiO6A0fjRbV6HBqW8aEorcA@mail.gmail.com>

On Wed, Oct 28, 2026 at 11:34:04AM +1000, Sam H wrote:
> >> I have a 32-bit Windows 2000 guest running the PAE kernel
> >
> > On purpose?  :-D
> 
> My face when I accidentally boot a Windows 2000 guest running the PAE
> kernel again xD
> 
> Unfortunately, I inherited it. It's for a monolith app running on
> servers older than I am. We are currently trying to strangler fig it
> out of existence into microservices, but until the last vine closes in
> it has to keep running. When they bought the replacement hypervisor
> server, before I started, they didn't think (or know) to check for
> things like this, so the old dying box with Intel CPU's works fine and
> the new AMD one doesn't.
> 
> >> Host
> >> - 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d
> >
> > Do you have access to Zen4+ hardware?  If this only reproduces on Rome (Zen2),
> > then unfortunately the answer is going to be "don't run AVIC on Rome".
> 
> Yes, and it reproduces on Zen 4 as well.
> 
> I copied the same disk clone to a Zen 4 host and ran it with the same
> QEMU arguments and the same stress load. It crashed twice out of two
> valid runs.
> 
> Zen 4 host
> - AMD Ryzen Threadripper 7960X (family 19h, model 0x18), 1 socket,
> microcode 0xa10810c, CPU flags avic and x2avic
> - Ubuntu 24.04, kernel 7.0.0-38.38~24.04.4-generic (based on 7.0.14)
> - QEMU 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.18)
> - kvm_amd: avic=Y, enable_ipiv=Y, vnmi=Y, npt=Y
> - AVIC confirmed active during the runs with kvm tracing, not only
> from the module parameter
> 
> Guest (same as the Rome runs)
> - Same disk clone, booted on a throwaway qcow2 overlay each run
> - Windows 2000 Datacenter Server SP4 kernel (5.00.2195.6717), boot.ini
> /PAE /3GB, CR4 0x6b1 on all 8 vCPUs
> - -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
> 8192 MiB, numa on
> - -machine hpet=off -rtc driftfix=slew -global kvm-pit.lost_tick_policy=discard
> 
> Results
> - AVIC on, /PAE /3GB: crashed within 28 s of starting the stress
>   STOP 0x0000004E PFN_LIST_CORRUPT (0x00000099, 0x0, 0x0, 0x00000000)
> - AVIC on, /PAE /3GB, repeat: crashed 10 s after starting the stress
>   STOP 0x0000004E PFN_LIST_CORRUPT (0x00000099, 0x0, 0x1, 0x00000000)
> 
> The stop code is different from Rome (0x0A there), but the pattern is
> the same. Parameter 1 0x99 is a PTE pointing at an invalid PFN, and
> the PFN is 0. That fits a page table read coming back as zero, which
> is what the 0x0A crashes on Rome showed. At the time of the crash 7 of
> the 8 vCPUs were stopped at the same EIP (0xDD431D87), and the
> crashing vCPU was at 0xDD069C0E doing port I/O to 0x1F0 while it wrote
> the dump. The EIPs differ from my first mail because this clone is now
> on the SP4 kernel and not Update Rollup 1.
> 
> Things that differ from the Rome host, for completeness: QEMU 8.2.2
> here against 11.0.3 there, enable_ipiv=Y here against N there, and
> x2AVIC and vNMI are available here.
> 
> What I do not have yet
> - A clean AVIC off control on the Zen 4 host. My one attempt did not
> finish booting the guest and I stopped it before any stress ran, so I
> am not counting it. I will rerun it and follow up with the result.

So, the guest boots only if AVIC is enabled?

> - A reproducer I can share. The disk clone holds company data and
> Windows 2000 is not mine to redistribute. A Debian 12 i386 guest on
> the 686-pae kernel, same QEMU machine plus kvm=off -x2apic, under a
> fork/exec/exit storm (about 21,600 forks/s across 8 vCPUs) ran for
> about 4 minutes without a crash. That is a short run, so I would not
> call it conclusive. Next I will try a clean Windows 2000 SP4 install
> with the same QEMU arguments and boot.ini. If that crashes, I can send
> the full steps to rebuild it from your own media plus the stress
> script, which is ours.

Did you get to try with a fresh image?

> 
> In the meantime the offer stands. I can run any patch or debug build
> against the clone on either host, and I can send vCPU register
> captures and KVM traces from the Zen 4 crashes. The full memory dumps
> contain company data, so I can't post those, but I can pull anything
> specific out of them on request.
> 
> Thanks,
> Sam Howell
> 
> On Tue, 27 Oct 2026 at 23:48, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Oct 27, 2026, Sam H wrote:
> > > Hey KVM Team,
> > >
> > > I have a 32-bit Windows 2000 guest running the PAE kernel
> >
> > On purpose?  :-D
> >
> > > that bugchecks within 15 to 134 seconds under a process churn load on an AMD
> > > Zen 2 host with AVIC enabled. The same guest survives the same load with AVIC
> > > off, or with PAE off. I have a disk clone that reproduces it on demand and
> > > can test patches against it.
> > >
> > > Host
> > > - 2 x AMD EPYC 7402 (family 17h), microcode 0x830107d
> >
> > Do you have access to Zen4+ hardware?  If this only reproduces on Rome (Zen2),
> > then unfortunately the answer is going to be "don't run AVIC on Rome".
> >
> > > - Proxmox VE 9.2.21, kernel 7.0.14-25-pve, QEMU 11.0.3 (pve-qemu-kvm 11.0.3-4)
> > > - kvm_amd: avic=Y, enable_ipiv=N, npt=Y
> > > - Also crashes on 6.14.8-2-pve (no enable_ipiv parameter on that kernel)
> > >
> > > Guest
> > > - Windows 2000 Datacenter Server SP4, boot.ini /PAE /3GB (ntkrpamp)
> > > - Crashes on both the SP4 kernel (5.00.2195.6717) and the Update
> > > Rollup 1 kernel (5.00.2195.7045)
> > > - -cpu kvm64, machine pc-i440fx-5.1, 2 sockets x 4 cores (8 vCPU),
> > > 8192 MiB, numa on
> > > - Extra args: -machine hpet=off -rtc driftfix=slew -global
> > > kvm-pit.lost_tick_policy=discard (the PIT policy is what keeps AVIC
> > > active for this guest)
> > >
> > > Crash
> > > - STOP 0x0000000A IRQL_NOT_LESS_OR_EQUAL, IRQL 2, always in ntkrnlpa.exe.
> > > - SP4 kernel: 0x0A (0x00000154, 2, 0, 0xDD537EAF), ntkrnlpa+0x137EAF,
> > > mov ecx,[ebx+0x154] with ebx = 0 or 0xF000FF53 (the real mode IVT
> > > pattern, i.e. the contents of guest physical page 0).
> > > - UR1 kernel: 0x0A (0x00000098, 2, 0, 0xDD53C9E6), ntkrnlpa+0x13C9E6,
> > > read of [esi+0x98] with esi = 0.
> > > - One write variant was also seen: 0x0A (0x00000098, 2, 1, 0xDD53C84C).
> > > - The faulting code is the PAE memory manager's hyperspace page table
> > > walk: it maps a page table page into a per-CPU hyperspace slot by
> > > writing a PTE, then reads through the slot, and the read comes back
> > > zero.

I don't see how AVIC can possibly influence this.

> > > - When it crashes, 7 of the 8 vCPUs are stopped at the same EIP
> > > (0xDD4335C3) and the crashing vCPU is at 0xDD06A1A6.
> > >
> > > Reproducer
> > > 6 concurrent sessions, each looping 200 short cmd.exe processes plus
> > > one debug.exe, so heavy process create and exit.
> > >
> > > Results on the clone (stress started after boot, same disk each time;
> > > 8 vCPU 2x4, kvm64, numa on, 8192 MiB unless stated)
> > > - AVIC on, /PAE /3GB (baseline): crashed at 134 s
> > > - AVIC on, /3GB only, no /PAE: survived 300 s
> > > - AVIC on, /PAE /3GB, 3584 MiB (no RAM above 4 GB): crashed at 26 s
> > > - AVIC on, /PAE without /3GB: crashed at 30 s
> > > - AVIC on, /PAE /3GB, QEMU vapic=off: crashed at 26 s
> > > - AVIC off (PIT reinject), /PAE /3GB: survived 600 s, twice

Do you need /3GB? Can you try AVIC off (inhibited rather) without /3GB?  
I'll be interested to know if any AVIC off/inhibited scenarios with /PAE 
can reproduce this.

> > > - AVIC on, /PAE /3GB, repeat with tracing: crashed at 15 s
> > > - AVIC on, /PAE /3GB, 1 socket x 8 cores: crashed at 50 s
> > > - AVIC on, no /PAE, 30 minute soak: survived 1800 s
> > >
> > > The production copy of the guest also crashed 3 times in one day on a
> > > single vCPU with AVIC on (7.0.14-25, enable_ipiv=N), so one vCPU
> > > lowers the rate but does not remove it. Setting the CPU vendor to
> > > GenuineIntel made no difference. During a traced run the AVIC IRQ
> > > window toggled about 1 to 2 times a second, so I do not think it is
> > > the IRQ window inhibit issue.

Right - if AVIC has any role here, it has to do with APIC Register 
access acceleration.

> > >
> > > The same guest image ran on an Intel Xeon E5-2620 v4 host (Proxmox VE
> > > 5.4, kernel 4.15) for years and has no crash dumps on its disk from
> > > that time.

That's an old kernel. If you have access to it, will you be able to try 
a newer kernel/QEMU on it?

In fact, it will be nice if you can try the above test matrix on an 
Intel box too -- it will be good to understand if all those combinations 
work well on Intel.

> > >
> > > What I have not tested: npt=0, because AVIC needs NPT, so npt=0 would
> > > also turn AVIC off and could not tell the two apart from the AVIC off
> > > run above. It would also be a host wide change on a host running ~70
> > > other production workloads/guests, and we can't risk performance
> > > impacts. Also kernels other than 6.14 and 7.0.
> > >
> > > A possibly relevant difference: AMD APM Vol 2 section 15.25.10 says
> > > that under nested paging the guest's PAE PDPTEs are not loaded at MOV
> > > CR3 the way they are natively or under Intel EPT. I have not proven
> > > that is the mechanism, and the AVIC off result says interrupt delivery
> > > or timing plays a part as well.
> > >
> > > I can provide the two minidumps, register captures of all vCPUs at the
> > > moment of a crash, and KVM traces, and I can run any patch against the
> > > clone.
> > >
> > > Thanks,
> > > Sam Howell
> > >


- Naveen

