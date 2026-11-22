Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377072;
	b=Hn6Wzw+XD3dPRYXUDBTWMQfk+zsndyeP/RxmGTGTDTpUpUteUfep8a8hg4EctDOUVkpw
	 AsSImhtzpHIPt8KZUlYAvZ49JceKl4jheVNUbFDqMSmPt1R2aXCKkaL/IYr36Gx/9JE+I
	 hYv87onELVR60fXC9jVbiR3gQRLC4jCstiL1xTPboOFkUDIlCgI/F/nHiWE0Qa8nldNtW
	 yruJ7HhK2QaeGYVKyc/KSEtl3vKDzDN3H2Zb9dpazlCyIx72oYp2c5wNLyJXohJEycRVU
	 Agr/hAFtpebTkDAJr03a0V3UiXdfHZA5JA9MRjG6KvHkJL+mD3hgAxfgZFmtKKey/UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377072;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=SM3ukCOF6/Ex4qdznBpXqwfNhfkDEI11TBQXbVwrMiU=;
	b=d+PDMC8SI8vjzspcaMRwuGHDdFkx42YDJJSTDs4MVAOPB780n3oeX1EM0U+zrDhlMYlg
	 lJZ0wn1OuKCl3xeyB2REN80c0Wrn0486Z8NIWG11QDzJ4lq/eqJEkvC06vI42hZWO1feu
	 WTxExGIc+XcAeY2gRKiD0+gfyqZHvhSs3pzvLOtrs3PjkkWTbwISo/UYQCX1b3UzYIdk2
	 nzexck2KHbb1Jzh5OjKt/AYunCR0TDTCCRG+PNVfiPUUX1N8AXL8af5iDbjRHht8DFPvQ
	 fKpevYlamfZWB0vkg1++eHNtauvUjstusqDySifJ3UOFtN8MyWLd4X18Bwf0NN7vK9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcDFIXQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0E606A31A
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcDFIXQb
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF0A1F000C4
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377072;
	bh=SM3ukCOF6/Ex4qdznBpXqwfNhfkDEI11TBQXbVwrMiU=;
	h=From:To:Subject:Date;
	b=IcDFIXQbkGV1zKwLJzKXDr1jOR8gzBRt0RrfglL/aOGL6OjiDsZISrfORGfmOVObe
	 TO/82TaZGlInX3phdm4Y4AKTKSXhPiDyv8s8bovNIXaoh3GDKImA1oLdxMw5nzvFLX
	 t9wLNwzskBw1SvgArtaENu0uEpMoHtny3Q1EPspdj8tR5Du/w/v7j31EwRrWxCLStk
	 D/jL3xWw0huaeEEJReYy2Nj9M4MMBa+Qnkvu8GwSgFjKIZ/z/x2/aZaDSixNm/lzZ0
	 Ccc1mQP86Lr5kEyup/HvOPT8AYmK0TOfe1oRt9I71e5xCjfMqj6iOOV/q94nlalolv
	 h2UEye99K8NLA==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id EC1CC240040C; Sun, 22 Nov 2026 19:51:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 222317] New: pci: 8086:4c43 host bridge enumerated as class
 0x0604 breaks Intel IGD passthrough
Date: Sun, 22 Nov 2026 19:51:11 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: PCI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 2039475150@qq.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_pci@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 cf_regression
Message-ID: <bug-222317-28872@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222317

            Bug ID: 222317
           Summary: pci: 8086:4c43 host bridge enumerated as class 0x0604
                    breaks Intel IGD passthrough
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: 2039475150@qq.com
                CC: kvm@vger.kernel.org
        Regression: No

Filed under Drivers/PCI because the underlying defect is the PCI class code
enumeration of the CPU host bridge; the visible failure happens in vfio-pci.
CC'd VFIO/KVM people for the driver side.

Passing the integrated GPU (Intel UHD Graphics P750, 8086:4c90) to a QEMU/K=
VM
guest fails on this machine. vfio_pci_igd_cfg_init() returns -EINVAL during
vfio_pci_open_device(), so QEMU never gets the device:

    vfio-pci 0000:00:02.0: resetting
    vfio-pci 0000:00:02.0: reset done
    vfio-pci 0000:00:02.0: Failed to setup Intel IGD regions
    kvm: -device vfio-pci,host=3D0000:00:02.0,...: vfio 0000:00:02.0:
         error getting device from group 0: Invalid argument

Root cause
----------

drivers/vfio/pci/vfio_pci_igd.c, vfio_pci_igd_cfg_init():

    host_bridge =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
    if (!host_bridge)
            return -ENODEV;

    if (host_bridge->vendor !=3D PCI_VENDOR_ID_INTEL ||
        host_bridge->class !=3D (PCI_CLASS_BRIDGE_HOST << 8)) {
            pci_dev_put(host_bridge);
            return -EINVAL;
    }

This firmware enumerates the CPU host bridge 00:00.0 (Intel 8086:4c43,
Rocket Lake-S Host Bridge/DRAM Controller) with class code 0x060400
(PCI-to-PCI bridge) instead of the architecturally correct 0x060000
(Host Bridge):

    $ setpci -s 00:00.0 0x09.b 0x0a.b 0x0b.b
    00 04 06          # class 0x060400

    $ setpci -s 00:00.0 HEADER_TYPE.b
    01                # type 1 header, i.e. looks like a PCI bridge

    $ setpci -s 00:00.0 0x18.l
    ffffffff          # primary/secondary/subordinate bus numbers all 0xff

lspci -t shows the PCI core actually walking that bogus secondary bus:

    -[0000:00]-+-00.0-[ff]--
               +-01.0-[02]----00.0
               +-02.0
               ...

The other half of the IGD check passes: the OpRegion is valid.

    $ setpci -s 00:02.0 fc.l
    953ce018          # OpRegion base in PCI config space 0xFC

    # read at that physical address:
    000000  49 6e 74 65 6c 47 72 61 70 68 69 63 73 4d 65 6d  IntelGraphicsM=
em
    000010  08 00 00 00 00 00 01 02 ...                      size =3D 8 KB

So vfio_pci_igd_opregion_init() succeeds and only
vfio_pci_igd_cfg_init() fails. The IGD itself is fine; the failure is purely
the host-bridge class check.

Why this is worth fixing in the kernel
--------------------------------------

The class code is a read-only PCI register and 0x0604 here is a firmware
defect. A user cannot fix it. The only workaround I found is patching the
cmpl immediate inside vfio-pci.ko after every kernel upgrade:

    bf3: 81 78 44 00 00 06 00   cmpl $0x60000,0x44(%rax)   # stock
         81 78 44 00 04 06 00   cmpl $0x60400,0x44(%rax)   # patched

With that two-byte change the check passes and the host-bridge, LPC and
OpRegion regions all register correctly; QEMU then reports a real Intel IGD
instead of a plain PCI device. This is a poor long-term solution: it breaks=
 on
every rebuild and requires stripping the module signature.

Suggested fixes
---------------

1. Preferred: a DMI-scoped quirk in drivers/pci/quirks.c that restores
   dev->class =3D PCI_CLASS_BRIDGE_HOST << 8 for 8086:4c43 on the affected
   board(s) only. This keeps the change off the other machines that report
   8086:4c43 with the correct 0x0600, and it fixes the value for every
   consumer instead of only vfio.

       static void quirk_intel_host_bridge_class(struct pci_dev *dev)
       {
               dev->class =3D PCI_CLASS_BRIDGE_HOST << 8;
       }
       DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4c43,
                               quirk_intel_host_bridge_class);

   guarded by dmi_check_system() for Gigabyte/W480 VISION W.

2. Alternative: an explicit escape hatch in vfio-pci (module parameter or
   sysfs attribute) to relax the host-bridge class check, so affected users
   do not have to binary-patch the module.

I understand neither option "fixes the firmware", and that the class
check\nexists for a reason. Option 1 seems the least invasive way to make t=
his
hardware usable.

Environment
-----------

    CPU:      Intel Xeon W-1390P (Rocket Lake)
    Board:    Gigabyte W480 VISION W, BIOS F25a (2026-06-11)
    iGPU:     0000:00:02.0  Intel UHD Graphics P750 [8086:4c90] rev 04
    Host Br:  0000:00:00.0  Intel [8086:4c43] rev 01, class 0x060400
    IOMMU:    group 0, iGPU alone
    Kernel:   7.0.14-28-pve (Proxmox VE 9.2, based on Ubuntu-7.0.0 + stable)
    cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.0.14-28-pve root=3D/dev/mapper/p=
ve-root
ro quiet
    CONFIG_VFIO_PCI=3Dm

Note: this board also hit a separate PCI bug involving
CONFIG_PCI_DYNAMIC_OF_NODES
(CVE-2026-98504, fixed in 7.3-rc5 / 6.18.55). That is unrelated to this rep=
ort;
CONFIG_PCI_DYNAMIC_OF_NODES is not even enabled in this build.

Note 2: the failing sequence above was observed on an earlier kernel on this
machine; on the current 7.0.14-28-pve the module is locally patched, so dme=
sg
no longer shows it. drivers/vfio/pci/vfio_pci_igd.c is unchanged in v7.3.3.

--=20
You are receiving this mail because:
You are on the CC list for the bug.=
