Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.244.238.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904127;
	b=qUGB+LSMM9rIWYrgUVg8W8TbO13od3Dvq19pmnYnC+/reDgCvtkCTeZncMprUx9QIoQK
	 YG5nyvnBlVSb/6VBUr5YVJyR12XNQ11SNEp1aGVgrczwsZQpMOL3StIUdDSrqOqmx4DFx
	 QFyuazOv43KJtGkwiyBNbza7b64zfTzbvmRBmBUjQErcC6vQoEo6WBwoj4q/PEBxyHuDL
	 SDm0E6r0540lET3yzRYAzFsfN76ScT0QnR5XUpSNjyZCAImIfTYILZDrU1PIhw+60uc5J
	 ZYJKrPQWxueyH7BBdaE06QBk0R6Y/NfS0txojBvdFig22J+/5NKkVdEGKeK9MIishhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904127;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:MIME-Version:Date:From:To:
	 Subject:Message-ID:X-Sender:Content-Type:Content-Transfer-Encoding;
	bh=p/k3AvCy3hsD54FMCbJfMxdgNBRvrfcrG2Je6J76mZI=;
	b=cAFP7nk2EGYUnN84jX0gbFq1n9Rqsx01fetYz/pDktfxOAlEnofn2ZKRKpW2DyUgEe9U
	 hQ/9KO+YrhxGWQ0m2FSd8s0IpsAhXzC34pnM1/BSY3oVGR+AbDnXPneq75KEitNgrab3R
	 U9JMNLL3tYu5c1fKYE4eCGijjZr/iFABYH1SZz2558h1Ykku6CWCgMzvr3/yyZD923/qZ
	 6l6OB6s06WfaLitEqWWew4a2MA6gv+8EbH/mgTQ8/gsE1XXhNYWc93M7HfQDBh0XyXZNq
	 UBmqCauWGTQBVy3kNLvauMxx3Hf8P7yPrcuB6EeIpDSv8Mp7uNvWo58ra3hpou/ipYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=panayotis.com;
	spf=pass smtp.mailfrom=panayotis.com;
	dkim=pass header.d=panayotis.com header.i=@panayotis.com header.a=ed25519-sha256 header.s=202512e header.b=NMHPyGlJ;
	dkim=pass header.d=panayotis.com header.i=@panayotis.com header.a=rsa-sha256 header.s=202512r header.b=p24rUjpt;
	arc=none smtp.remote-ip=207.244.238.246
Received: from yot.is (yot.is [207.244.238.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1217606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1217606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=panayotis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panayotis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=panayotis.com header.i=@panayotis.com header.a=ed25519-sha256 header.s=202512e header.b=NMHPyGlJ;
	dkim=pass (2048-bit key, unprotected) header.d=panayotis.com header.i=@panayotis.com header.a=rsa-sha256 header.s=202512r header.b=p24rUjpt
DKIM-Signature: v=1; a=ed25519-sha256; s=202512e; d=panayotis.com; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1793904120; bh=p/k3AvCy3hsD54FMCbJfMxd
	gNBRvrfcrG2Je6J76mZI=; b=NMHPyGlJDXS3gVRFiIkL49Mejx5kvfpfBaf26vE9yLZrXX9OGZ
	0FMzrvEXQJlElGqMK84nzWIZT7YZRGQ0PACQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202512r; d=panayotis.com; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1793904120; bh=p/k3AvCy3hsD54FMCbJfMxd
	gNBRvrfcrG2Je6J76mZI=; b=p24rUjptOCpLbCzjdpj104i3exqqYwJ8y7oWP3l4xMUuJAtV7P
	CBaOtjVNrT92dWnfTrpTBU3n6K5+5ZBSCTRJjjcc5IvmHdFsUrklZsfYGUfX3Ieh/luT9CY6o2d
	Vo+vyNywhzp5XJ3fUVDHehvA17SEbv/zg25exCDrGXUcIJ0XIuZI023DESzGH3sqlHIuICJBGis
	hKuur82YbaJcm04MpFTypeGLIQ30XuNpzGUG5yPROz0KlwbWFwY8+yCr4uk0Chr43s929I96Rho
	9+uzRY87HYMZseitwa+9wy8cYkWtlE4McTfBtuaYZx+DPIJ4YfglVmvvd2kIyGKOu+g==;
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 05 Nov 2026 20:42:00 +0200
From: Panayotis Katsaloulis <panayotis@panayotis.com>
To: kvm@vger.kernel.org
Subject: nVMX: Windows 11 with nested Hyper-V fails to boot when MBEC is
 exposed to L1 (7.2)
Message-ID: <58dcd595e3187d335e103a042d196cb7@panayotis.com>
X-Sender: panayotis@panayotis.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After updating the host from 7.1.13 to 7.2.9, a Windows 11 guest that
runs its own hypervisor (VBS / Hyper-V, hypervisorlaunchtype Auto) no
longer boots. It fails very early (no bugcheck, no minidump, bootstat
not updated) and ends in Automatic Repair ("Your device ran into a
problem and couldn't be repaired"). Startup Repair reports no root
cause.

Hiding MBEC from the guest is enough to make it boot again:

   -cpu host,migratable=on,vmx=on,vmx-mbec=off,hv-...

Host:
   CPU:      Intel Core i9-13900 (Raptor Lake)
   Kernel:   7.2.9 (distro kernel, Manjaro), kvm_intel nested=Y, mbec=Y
   QEMU:     11.1.2 (also reproduced with 11.1.1)
   libvirt:  12.8.0
   OVMF:     edk2 202608, Secure Boot, swtpm 0.10.2 (TPM 2.0, CRB)
   Machine:  pc-q35-9.2

Guest:
   Windows 11 24H2 (build 26100), UEFI + Secure Boot, VBS enabled,
   hypervisorlaunchtype Auto, 8 GiB, host-passthrough CPU.
   Hyper-V enlightenments: relaxed, vapic, spinlocks, vpindex, runtime,
   synic, stimer, frequencies, tlbflush, ipi, evmcs, avic, hypervclock.

Results (host kernel 7.2.9 in all cases):

   vmx  vmx-mbec  hv-evmcs  QEMU    result
   on   default   on        11.1.2  fails (Automatic Repair)
   off  n/a       on        11.1.2  boots
   on   default   on        11.1.1  fails
   on   off       on        11.1.1  boots
   on   default   off       11.1.1  fails

The same guest, with an identical QEMU command line (compared from the
libvirt log; only fds/ids differ), last booted fine on 2026-10-23 on
7.1.13 with QEMU 11.1.1. So disabling eVMCS does not help, and QEMU
and libvirt do not seem to be involved; the only difference that
matters is whether MBEC is offered to L1.

What I could not test:
   - 7.1.x with the exact same setup again (no longer installable here)
   - latest 7.2.y / 7.3.y
   - kvm_intel.mbec=0 (I expect it to behave like vmx-mbec=off)

Someone else reports the same symptom (7.1.8 works, 7.2.x fails,
Windows 11 26100 with nested Hyper-V), without a root cause:
https://discuss.cachyos.org/t/windows-11-kvm-guest-with-nested-hyper-v-boot-loops-on-linux-cachyos-7-2-x-works-on-7-1-8/36134

I can test patches or collect traces if that helps.

Thanks,
Panayotis
