Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811E2FFDCB;
	Sun, 17 May 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024301; cv=none; b=bzj8Fx6X4hfviUjozgpI3aGRi4okLCVC/Ap7/9E/bHzKIGiCSET2VPaNcO3wnIpQMY3NBxtXt0CPINoMQYHLqhShsmCsjb/zVp1rUtbTGpe2TkbZZEJ1SolvMW6usO+yaEWUiWZbVPpiqBN1eBdeoDClPArMf0KUxeCmGjhciEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024301; c=relaxed/simple;
	bh=caCfMIIPZ+PZytlcvUWbsHDYrwnCpD8qROa+Yy9Ljh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwznz13k4ASrkhMEOKF68AqSuApYTHIXOybQZgMySYJvsZe12xO27loj5IVX9BDN3o5T5KvgTEPMK+6VT5fKZ9ps9gMrx/n+CCC2h++UQ4GY93uw0uYdJ37XmG9M8YS3/G62sTIstp5p9thKkRnHYb3QX+bTDkSOyY68UVkiPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=b5dt0Pdv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="b5dt0Pdv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=5wZh2ij/mQUgGxWlOfYtsCfpgcTNQcGDXN4Jva3xgX8=; b=b5dt0PdvezdHrBzx4DGE/t3wSN
	uR8IECrkGBzW1ymrrOxeO/LwAvjAzpJsj15nAFBbUs5xPyHBCQQIhm8otnGUO2iZB9H3SgbTjf0oj
	WnD04JyUtlKfmhPupvE1ztZR3Jlq/UyHcAEYEF13GBy4JMMxcsixsRtqTqeMv//PMOyQL9QyT/rXQ
	JLMnk82zsGzDltiK3GSuupWQgxblhbLqa8kQEY1uw3Pvxf92C8kiIcfMPm7ckPn082oXvBZmBdZeV
	3qVOhtPmnCEbSPD3P5v6lcVhwU3r4RVkeb9jzOblNFA8ZaAeiaLAJQeGazjEZS30LwFw3kF1udSEP
	Vfq5au7Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wObTp-000oCQ-1E;
	Sun, 17 May 2026 13:24:29 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 404C9BE2EE7; Sun, 17 May 2026 15:24:27 +0200 (CEST)
Date: Sun, 17 May 2026 15:24:27 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Maximilian Senftleben <kernel@0in.de>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: 1135235@bugs.debian.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1135235: linux-image-6.19.13+deb14-amd64: Reoccuring host
 crash "Invalid SPTE change" with gaming win kvm/qemu guest and device
 passthrough
Message-ID: <177902420697.2035014.8796825668567298024@eldamar.lan>
References: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
X-Debian-User: carnil

Control: forwwarded -1 https://lore.kernel.org/all/177902420697.2035014.879=
6825668567298024@eldamar.lan

Hi

Maximilian Senftleben reported the following in Debian (cf.
https://bugs.debian.org/1135235), it should be noted while Maximilian
uses the looking-glass application (which is acompanied with dkms
modules, they are not loaded and do not tain the kernel). Do you have
an idea how to debug this?

On Wed, Apr 29, 2026 at 09:17:14PM +0200, Maximilian Senftleben wrote:
> Package: src:linux
> Version: 6.19.13-1
> Severity: important
>=20
> Dear Maintainer,
>=20
> - I have a Windows kvm/qemu guest that uses device passthrough for my GPU.
> - Sometimes while playing the host system crashes/freezes, this only happ=
ens
> during load/gaming, and sometimes 1-2 times a day, sometimes not at all.
>=20
>=20
> System:
> Linux myhost 6.19.13+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.19.13-1
> (2026-04-18) x86_64 GNU/Linux
>=20
> CPU:
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 183
> model name      : Intel(R) Core(TM) i5-14400
> [...]
>=20
> Apr 29 12:10:33 myhost kernel: kvm: Invalid SPTE change: cannot replace a=
 present leaf
>                                        SPTE with another present leaf SPT=
E mapping a
>                                        different PFN!
>                                        as_id: 0 gfn: 80ec33 old_spte: 860=
000aae3d00bc8 new_spte: 86000009e3d00b77 level: 1
> Apr 29 12:10:33 myhost kernel: ------------[ cut here ]------------
> Apr 29 12:10:33 myhost kernel: kernel BUG at arch/x86/kvm/mmu/tdp_mmu.c:6=
00!
> Apr 29 12:10:33 myhost kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
> Apr 29 12:10:33 myhost kernel: CPU: 7 UID: 1000 PID: 8419 Comm: CPU 2/KVM=
 Not tainted 6.19.13+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.19.13-1=20
> Apr 29 12:10:33 myhost kernel: Hardware name: Micro-Star International Co=
=2E, Ltd. MS-7D96/MAG B760 TOMAHAWK WIFI (MS-7D96), BIOS A.B0 10/07/2024
> Apr 29 12:10:33 myhost kernel: RIP: 0010:handle_changed_spte.cold+0x1d/0x=
84 [kvm]
> Apr 29 12:10:33 myhost kernel: Code: fb c1 4c 8b 44 24 78 48 8b 0c 24 eb =
b0 48 8b 14 24 8b 74 24 18 45 89 e9 4d 89 e0 48 89 e9 48 c7 c7 98 6d cf c1 =
e8 2d 49 69 c1 <0f> 0b 48 63 d1 be 01 00 00 00 4c 89 54 24 40 48 c7 c7 20 6=
5 e0 c1
> Apr 29 12:10:33 myhost kernel: RSP: 0018:ffffd100808b78d8 EFLAGS: 00010246
> Apr 29 12:10:33 myhost kernel: RAX: 00000000000000c8 RBX: ffff8eb26206200=
0 RCX: 0000000000000000
> Apr 29 12:10:33 myhost kernel: RDX: 0000000000000000 RSI: 000000000000000=
1 RDI: ffff8ebf7f5dd2c0
> Apr 29 12:10:33 myhost kernel: RBP: 860000aae3d00bc8 R08: 000000000000000=
0 R09: ffffd100808b7780
> Apr 29 12:10:33 myhost kernel: R10: ffffffff850dbfe8 R11: 00000000ffffeff=
f R12: 86000009e3d00b77
> Apr 29 12:10:33 myhost kernel: R13: 0000000000000001 R14: 00000000009e3d0=
0 R15: 0000000000000001
> Apr 29 12:10:33 myhost kernel: FS:  00007f23e5dff6c0(0000) GS:ffff8ebff99=
66000(0000) knlGS:ffffde0104510000
> Apr 29 12:10:33 myhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Apr 29 12:10:33 myhost kernel: CR2: 0000016ddcd2e000 CR3: 000000017fe6b00=
4 CR4: 0000000000f72ef0
> Apr 29 12:10:33 myhost kernel: PKRU: 55555554
> Apr 29 12:10:33 myhost kernel: Call Trace:
> Apr 29 12:10:33 myhost kernel:  <TASK>
> Apr 29 12:10:33 myhost kernel:  kvm_tdp_mmu_map+0x642/0x890 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __pfx_handle_ept_violation+0x10/0x10 [k=
vm_intel]
> Apr 29 12:10:33 myhost kernel:  kvm_tdp_page_fault+0xc4/0xf0 [kvm]
> Apr 29 12:10:33 myhost kernel:  kvm_mmu_do_page_fault+0x1d9/0x210 [kvm]
> Apr 29 12:10:33 myhost kernel:  kvm_mmu_page_fault+0x7e/0x790 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? asm_fred_entry_from_kvm+0x58/0x60
> Apr 29 12:10:33 myhost kernel:  ? vmx_vmexit+0x9d/0xd0 [kvm_intel]
> Apr 29 12:10:33 myhost kernel:  ? __pfx_handle_ept_violation+0x10/0x10 [k=
vm_intel]
> Apr 29 12:10:33 myhost kernel:  vmx_handle_exit+0x14f/0x8f0 [kvm_intel]
> Apr 29 12:10:33 myhost kernel:  kvm_arch_vcpu_ioctl_run+0x91e/0x18e0 [kvm]
> Apr 29 12:10:33 myhost kernel:  kvm_vcpu_ioctl+0x2e4/0xa00 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? vfio_pci_rw+0xa3/0x1a0 [vfio_pci_core]
> Apr 29 12:10:33 myhost kernel:  __x64_sys_ioctl+0x97/0xe0
> Apr 29 12:10:33 myhost kernel:  do_syscall_64+0x81/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_pread64+0xb0/0xd0
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0xbe/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? kvm_on_user_return+0x59/0xc0 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_ioctl+0xb1/0xe0
> Apr 29 12:10:33 myhost kernel:  ? fire_user_return_notifiers+0x37/0x60
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0x2b5/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? count_memcg_events+0xd6/0x210
> Apr 29 12:10:33 myhost kernel:  ? handle_mm_fault+0x1d6/0x2d0
> Apr 29 12:10:33 myhost kernel:  ? do_user_addr_fault+0x2b4/0x7b0
> Apr 29 12:10:33 myhost kernel:  ? irqentry_exit+0x6e/0x570
> Apr 29 12:10:33 myhost kernel:  ? exc_page_fault+0x7e/0x1a0
> Apr 29 12:10:33 myhost kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Apr 29 12:10:33 myhost kernel: RIP: 0033:0x7f2c02368d3b
> Apr 29 12:10:33 myhost kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 =
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 =
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 2=
8 00 00
> Apr 29 12:10:33 myhost kernel: RSP: 002b:00007f23e5dfe5c0 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
> Apr 29 12:10:33 myhost kernel: RAX: ffffffffffffffda RBX: 000055e177ba517=
0 RCX: 00007f2c02368d3b
> Apr 29 12:10:33 myhost kernel: RDX: 0000000000000000 RSI: 000000000000ae8=
0 RDI: 0000000000000028
> Apr 29 12:10:33 myhost kernel: RBP: 000000000000ae80 R08: 000055e146fe70d=
0 R09: 0000000000000004
> Apr 29 12:10:33 myhost kernel: R10: 0000070000000000 R11: 000000000000024=
6 R12: 0000000000000000
> Apr 29 12:10:33 myhost kernel: R13: 0000000000000006 R14: 000000000000007=
1 R15: 0000000000000000
> Apr 29 12:10:33 myhost kernel:  </TASK>
> Apr 29 12:10:33 myhost kernel: Modules linked in: vhost_net vhost vhost_i=
otlb tap tun rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUE=
RADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables br=
idge stp llc sunrpc uinput qrtr cmac algif_hash algif_skcipher af_alg bnep =
dm_crypt hid_corsair joydev snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd=
_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_in=
tel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda s=
oundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_hda_codec_intelhdmi snd=
_sof snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common iwlmvm snd_sof_uti=
ls snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks intel_uncore_fre=
quency soundwire_generic_allocation intel_uncore_frequency_common snd_soc_s=
dw_utils snd_soc_acpi snd_hda_codec_alc662 x86_pkg_temp_thermal crc8 intel_=
powerclamp snd_hda_codec_realtek_lib uvcvideo soundwire_bus coretemp mac802=
11
> Apr 29 12:10:33 myhost kernel:  snd_hda_codec_generic videobuf2_vmalloc s=
nd_soc_sdca uvc videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_soc_avs v=
ideodev snd_soc_hda_codec kvm_intel snd_hda_intel snd_usbmidi_lib snd_hda_e=
xt_core snd_rawmidi snd_hda_codec videobuf2_common snd_seq_device nls_ascii=
 mc hid_generic snd_soc_core nls_cp437 libarc4 iTCO_wdt snd_hda_core vfat i=
ntel_pmc_bxt kvm fat mei_hdcp mei_pxp spd5118 snd_intel_dspcfg iTCO_vendor_=
support snd_compress iwlwifi snd_intel_sdw_acpi watchdog snd_pcm_dmaengine =
snd_hwdep rapl snd_pcm intel_cstate r8169 battery snd_timer cfg80211 intel_=
uncore wmi_bmof mxm_wmi snd mei_me realtek pcspkr i2c_i801 i2c_smbus soundc=
ore mei fan btusb intel_pmc_core btmtk uas btrtl btbcm btintel pmt_telemetr=
y serial_multi_instantiate usb_storage bluetooth pmt_discovery pmt_class in=
tel_pmc_ssram_telemetry acpi_tad acpi_pad usbhid ecdh_generic hid button ev=
dev sg rfkill binfmt_misc dm_mod efi_pstore nfnetlink xe drm_ttm_helper drm=
_suballoc_helper gpu_sched drm_gpuvm drm_exec configfs drm_gpusvm_helper ex=
t4
> Apr 29 12:10:33 myhost kernel:  crc16 mbcache jbd2 crc32c_cryptoapi i915 =
drm_client_lib sd_mod i2c_algo_bit drm_buddy ttm drm_display_helper ahci dr=
m_kms_helper libahci xhci_pci libata xhci_hcd drm nvme nvme_core usbcore sc=
si_mod nvme_keyring cec nvme_auth video ghash_clmulni_intel hkdf rc_core sc=
si_common intel_vsec usb_common wmi pinctrl_alderlake vfio_pci vfio_pci_cor=
e irqbypass vfio_iommu_type1 vfio parport_pc lp ppdev parport i2c_dev msr e=
fivarfs autofs4 aesni_intel
> Apr 29 12:10:33 myhost kernel: ---[ end trace 0000000000000000 ]---
> Apr 29 12:10:33 myhost kernel: kvm: get_mmio_spte: reserved bits set on M=
MU-present spte, addr 0x80ec3098c, hierarchy:
> Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x8000000109193907 le=
vel =3D 4, rsvd bits =3D 0xfff80000000f8
> Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x80000008d8b33907 le=
vel =3D 3, rsvd bits =3D 0xfff8000000078
> Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x8000000371e37907 le=
vel =3D 2, rsvd bits =3D 0xfff8000000078
> Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x86000004e3cfdb26 le=
vel =3D 1, rsvd bits =3D 0xfff8000000000
> Apr 29 12:10:33 myhost kernel: ------------[ cut here ]------------
> Apr 29 12:10:33 myhost kernel: WARNING: arch/x86/kvm/mmu/mmu.c:4452 at kv=
m_mmu_page_fault.cold+0xc7/0xe4 [kvm], CPU#11: CPU 4/KVM/8421
> Apr 29 12:10:33 myhost kernel: Modules linked in: vhost_net vhost vhost_i=
otlb tap tun rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUE=
RADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables br=
idge stp llc sunrpc uinput qrtr cmac algif_hash algif_skcipher af_alg bnep =
dm_crypt hid_corsair joydev snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd=
_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_in=
tel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda s=
oundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_hda_codec_intelhdmi snd=
_sof snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common iwlmvm snd_sof_uti=
ls snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks intel_uncore_fre=
quency soundwire_generic_allocation intel_uncore_frequency_common snd_soc_s=
dw_utils snd_soc_acpi snd_hda_codec_alc662 x86_pkg_temp_thermal crc8 intel_=
powerclamp snd_hda_codec_realtek_lib uvcvideo soundwire_bus coretemp mac802=
11
> Apr 29 12:10:33 myhost kernel:  snd_hda_codec_generic videobuf2_vmalloc s=
nd_soc_sdca uvc videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_soc_avs v=
ideodev snd_soc_hda_codec kvm_intel snd_hda_intel snd_usbmidi_lib snd_hda_e=
xt_core snd_rawmidi snd_hda_codec videobuf2_common snd_seq_device nls_ascii=
 mc hid_generic snd_soc_core nls_cp437 libarc4 iTCO_wdt snd_hda_core vfat i=
ntel_pmc_bxt kvm fat mei_hdcp mei_pxp spd5118 snd_intel_dspcfg iTCO_vendor_=
support snd_compress iwlwifi snd_intel_sdw_acpi watchdog snd_pcm_dmaengine =
snd_hwdep rapl snd_pcm intel_cstate r8169 battery snd_timer cfg80211 intel_=
uncore wmi_bmof mxm_wmi snd mei_me realtek pcspkr i2c_i801 i2c_smbus soundc=
ore mei fan btusb intel_pmc_core btmtk uas btrtl btbcm btintel pmt_telemetr=
y serial_multi_instantiate usb_storage bluetooth pmt_discovery pmt_class in=
tel_pmc_ssram_telemetry acpi_tad acpi_pad usbhid ecdh_generic hid button ev=
dev sg rfkill binfmt_misc dm_mod efi_pstore nfnetlink xe drm_ttm_helper drm=
_suballoc_helper gpu_sched drm_gpuvm drm_exec configfs drm_gpusvm_helper ex=
t4
> Apr 29 12:10:33 myhost kernel:  crc16 mbcache jbd2 crc32c_cryptoapi i915 =
drm_client_lib sd_mod i2c_algo_bit drm_buddy ttm drm_display_helper ahci dr=
m_kms_helper libahci xhci_pci libata xhci_hcd drm nvme nvme_core usbcore sc=
si_mod nvme_keyring cec nvme_auth video ghash_clmulni_intel hkdf rc_core sc=
si_common intel_vsec usb_common wmi pinctrl_alderlake vfio_pci vfio_pci_cor=
e irqbypass vfio_iommu_type1 vfio parport_pc lp ppdev parport i2c_dev msr e=
fivarfs autofs4 aesni_intel
> Apr 29 12:10:33 myhost kernel: CPU: 11 UID: 1000 PID: 8421 Comm: CPU 4/KV=
M Tainted: G      D             6.19.13+deb14-amd64 #1 PREEMPT(lazy)  Debia=
n 6.19.13-1=20
> Apr 29 12:10:33 myhost kernel: Tainted: [D]=3DDIE
> Apr 29 12:10:33 myhost kernel: Hardware name: Micro-Star International Co=
=2E, Ltd. MS-7D96/MAG B760 TOMAHAWK WIFI (MS-7D96), BIOS A.B0 10/07/2024
> Apr 29 12:10:33 myhost kernel: RIP: 0010:kvm_mmu_page_fault.cold+0xc7/0xe=
4 [kvm]
> Apr 29 12:10:33 myhost kernel: Code: 60 26 e0 c1 e8 a5 8e fb c1 44 89 ea =
48 89 d9 4c 89 f6 48 c7 c7 70 67 cf c1 e8 20 50 69 c1 48 83 ed 08 45 89 fd =
e9 6e ff ff ff <0f> 0b b8 ea ff ff ff e9 47 10 fe ff 48 89 de 48 c7 c7 80 2=
6 e0 c1
> Apr 29 12:10:33 myhost kernel: RSP: 0018:ffffd100867db930 EFLAGS: 00010202
> Apr 29 12:10:33 myhost kernel: RAX: 000000000000004c RBX: 000fff800000000=
0 RCX: 0000000000000027
> Apr 29 12:10:33 myhost kernel: RDX: 0000000000000000 RSI: 000000000000000=
1 RDI: ffff8ebf7f6dd2c0
> Apr 29 12:10:33 myhost kernel: RBP: ffffd100867db988 R08: 000000000000000=
0 R09: ffffd100867db7d8
> Apr 29 12:10:33 myhost kernel: R10: ffffffff850dbfe8 R11: 00000000ffffeff=
f R12: 0000000000000001
> Apr 29 12:10:33 myhost kernel: R13: 0000000000000000 R14: 86000004e3cfdb2=
6 R15: 0000000000000000
> Apr 29 12:10:33 myhost kernel: FS:  00007f23cffff6c0(0000) GS:ffff8ebff9a=
66000(0000) knlGS:ffffde01045e6000
> Apr 29 12:10:33 myhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Apr 29 12:10:33 myhost kernel: CR2: 0000016dcbc5c000 CR3: 000000017fe6b00=
3 CR4: 0000000000f72ef0
> Apr 29 12:10:33 myhost kernel: PKRU: 55555554
> Apr 29 12:10:33 myhost kernel: Call Trace:
> Apr 29 12:10:33 myhost kernel:  <TASK>
> Apr 29 12:10:33 myhost kernel:  ? __kvm_io_bus_write+0x28/0xb0 [kvm]
> Apr 29 12:10:33 myhost kernel:  vmx_handle_exit+0x81a/0x8f0 [kvm_intel]
> Apr 29 12:10:33 myhost kernel:  kvm_arch_vcpu_ioctl_run+0x91e/0x18e0 [kvm]
> Apr 29 12:10:33 myhost kernel:  kvm_vcpu_ioctl+0x2e4/0xa00 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __kvm_io_bus_write+0x28/0xb0 [kvm]
> Apr 29 12:10:33 myhost kernel:  __x64_sys_ioctl+0x97/0xe0
> Apr 29 12:10:33 myhost kernel:  do_syscall_64+0x81/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? kvm_arch_vcpu_ioctl_run+0x22d/0x18e0 [k=
vm]
> Apr 29 12:10:33 myhost kernel:  ? kvm_vcpu_ioctl+0x275/0xa00 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? kvm_on_user_return+0x59/0xc0 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_ioctl+0xb1/0xe0
> Apr 29 12:10:33 myhost kernel:  ? fire_user_return_notifiers+0x37/0x60
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0x2b5/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? kvm_on_user_return+0x59/0xc0 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_ioctl+0xb1/0xe0
> Apr 29 12:10:33 myhost kernel:  ? fire_user_return_notifiers+0x37/0x60
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0x2b5/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? fire_user_return_notifiers+0x37/0x60
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0x2b5/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0xbe/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? do_futex+0xc5/0x190
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_futex+0x12d/0x220
> Apr 29 12:10:33 myhost kernel:  ? kvm_on_user_return+0x59/0xc0 [kvm]
> Apr 29 12:10:33 myhost kernel:  ? __x64_sys_ioctl+0xb1/0xe0
> Apr 29 12:10:33 myhost kernel:  ? do_syscall_64+0x245/0x5e0
> Apr 29 12:10:33 myhost kernel:  ? __irq_exit_rcu+0x3d/0xe0
> Apr 29 12:10:33 myhost kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Apr 29 12:10:33 myhost kernel: RIP: 0033:0x7f2c02368d3b
> Apr 29 12:10:33 myhost kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 =
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 =
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 2=
8 00 00
> Apr 29 12:10:33 myhost kernel: RSP: 002b:00007f23cfffe5c0 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
> Apr 29 12:10:33 myhost kernel: RAX: ffffffffffffffda RBX: 000055e177bb881=
0 RCX: 00007f2c02368d3b
> Apr 29 12:10:33 myhost kernel: RDX: 0000000000000000 RSI: 000000000000ae8=
0 RDI: 000000000000002c
> Apr 29 12:10:33 myhost kernel: RBP: 000000000000ae80 R08: 000055e146fe70d=
0 R09: 0000000000000004
> Apr 29 12:10:33 myhost kernel: R10: 000055e1797d3da0 R11: 000000000000024=
6 R12: 0000000000000000
> Apr 29 12:10:33 myhost kernel: R13: 0000000000000006 R14: 000000000000060=
8 R15: 0000000000000002
> Apr 29 12:10:33 myhost kernel:  </TASK>
> Apr 29 12:10:33 myhost kernel: ---[ end trace 0000000000000000 ]---
> Apr 29 12:10:33 myhost kernel: RIP: 0010:handle_changed_spte.cold+0x1d/0x=
84 [kvm]
> Apr 29 12:10:33 myhost kernel: Code: fb c1 4c 8b 44 24 78 48 8b 0c 24 eb =
b0 48 8b 14 24 8b 74 24 18 45 89 e9 4d 89 e0 48 89 e9 48 c7 c7 98 6d cf c1 =
e8 2d 49 69 c1 <0f> 0b 48 63 d1 be 01 00 00 00 4c 89 54 24 40 48 c7 c7 20 6=
5 e0 c1
> Apr 29 12:10:33 myhost kernel: RSP: 0018:ffffd100808b78d8 EFLAGS: 00010246
> Apr 29 12:10:33 myhost kernel: RAX: 00000000000000c8 RBX: ffff8eb26206200=
0 RCX: 0000000000000000
> Apr 29 12:10:33 myhost kernel: RDX: 0000000000000000 RSI: 000000000000000=
1 RDI: ffff8ebf7f5dd2c0
> Apr 29 12:10:33 myhost kernel: RBP: 860000aae3d00bc8 R08: 000000000000000=
0 R09: ffffd100808b7780
> Apr 29 12:10:33 myhost kernel: R10: ffffffff850dbfe8 R11: 00000000ffffeff=
f R12: 86000009e3d00b77
> Apr 29 12:10:33 myhost kernel: R13: 0000000000000001 R14: 00000000009e3d0=
0 R15: 0000000000000001
> Apr 29 12:10:33 myhost kernel: FS:  00007f23e5dff6c0(0000) GS:ffff8ebff99=
66000(0000) knlGS:ffffde0104510000
> Apr 29 12:10:33 myhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Apr 29 12:10:33 myhost kernel: CR2: 0000016ddcd2e000 CR3: 000000017fe6b00=
4 CR4: 0000000000f72ef0
> Apr 29 12:10:33 myhost kernel: PKRU: 55555554
> Apr 29 12:10:33 myhost kernel: note: CPU 2/KVM[8419] exited with preempt_=
count 1
> Apr 29 12:10:34 myhost looking-glass-client.desktop[17000]: 01:08:26.337 =
[I]              main.c:1751 | lg_run                         | Waiting for=
 the host to restart...
> Apr 29 12:10:54 myhost kernel: rcu: INFO: rcu_preempt self-detected stall=
 on CPU
> Apr 29 12:10:54 myhost kernel: rcu:         15-....: (5250 ticks this GP)=
 idle=3Ddce4/1/0x4000000000000000 softirq=3D753021/753022 fqs=3D2223
> Apr 29 12:10:54 myhost kernel: rcu:         (t=3D5251 jiffies g=3D1262685=
 q=3D2029 ncpus=3D16)
> Apr 29 12:10:54 myhost kernel: CPU: 15 UID: 1000 PID: 8403 Comm: qemu-sys=
tem-x86 Tainted: G      D W           6.19.13+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.19.13-1=20
> Apr 29 12:10:54 myhost kernel: Tainted: [D]=3DDIE, [W]=3DWARN
> Apr 29 12:10:54 myhost kernel: Hardware name: Micro-Star International Co=
=2E, Ltd. MS-7D96/MAG B760 TOMAHAWK WIFI (MS-7D96), BIOS A.B0 10/07/2024
> Apr 29 12:10:54 myhost kernel: RIP: 0010:queued_write_lock_slowpath+0x63/=
0x130
> Apr 29 12:10:54 myhost kernel: Code: ef c6 07 00 0f 1f 00 0f 1f 44 00 00 =
5b 5d c3 cc cc cc cc f0 81 0b 00 01 00 00 ba ff 00 00 00 8b 03 3d 00 01 00 =
00 74 0b f3 90 <8b> 03 3d 00 01 00 00 75 f5 b8 00 01 00 00 f0 0f b1 13 74 c=
0 eb df
> Apr 29 12:10:54 myhost kernel: RSP: 0018:ffffd10086e07920 EFLAGS: 00000206
> Apr 29 12:10:54 myhost kernel: RAX: 0000000000000300 RBX: ffff8eb26206200=
0 RCX: 0000000000000000
> Apr 29 12:10:54 myhost kernel: RDX: 00000000000000ff RSI: 00007f23d416571=
8 RDI: ffff8eb262062000
> Apr 29 12:10:54 myhost kernel: RBP: ffff8eb262062004 R08: ffffd1008a95500=
8 R09: 00007fff14e314d0
> Apr 29 12:10:54 myhost kernel: R10: 0000000000000000 R11: 000000000000000=
0 R12: ffff8eb262062000
> Apr 29 12:10:54 myhost kernel: R13: ffffd10086e079d8 R14: ffffd1008a95500=
8 R15: 0000000000000008
> Apr 29 12:10:54 myhost kernel: FS:  00007f2c0052e300(0000) GS:ffff8ebff9b=
66000(0000) knlGS:0000000000000000
> Apr 29 12:10:54 myhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Apr 29 12:10:54 myhost kernel: CR2: 0000016e38b10000 CR3: 000000017fe6b00=
4 CR4: 0000000000f72ef0
> Apr 29 12:10:54 myhost kernel: PKRU: 55555554
> Apr 29 12:10:54 myhost kernel: Call Trace:
> Apr 29 12:10:54 myhost kernel:  <TASK>
> Apr 29 12:10:54 myhost kernel:  kvm_clear_dirty_log_protect+0x191/0x2d0 [=
kvm]
> Apr 29 12:10:54 myhost kernel:  kvm_vm_ioctl+0x9f8/0x1ae0 [kvm]
> Apr 29 12:10:54 myhost kernel:  ? kvm_vm_ioctl+0x88c/0x1ae0 [kvm]
> Apr 29 12:10:54 myhost kernel:  __x64_sys_ioctl+0x97/0xe0
> Apr 29 12:10:54 myhost kernel:  do_syscall_64+0x81/0x5e0
> Apr 29 12:10:54 myhost kernel:  ? __pfx_pollwake+0x10/0x10
> Apr 29 12:10:54 myhost kernel:  ? find_vmap_area+0xc0/0xe0
> Apr 29 12:10:54 myhost kernel:  ? __check_object_size+0x1d3/0x240
> Apr 29 12:10:54 myhost kernel:  ? kvm_get_dirty_log_protect+0x1e6/0x290 [=
kvm]
> Apr 29 12:10:54 myhost kernel:  ? kvm_vm_ioctl+0x88c/0x1ae0 [kvm]
> Apr 29 12:10:54 myhost kernel:  ? __x64_sys_ioctl+0xb1/0xe0
> Apr 29 12:10:54 myhost kernel:  ? do_syscall_64+0xbe/0x5e0
> Apr 29 12:10:54 myhost kernel:  ? switch_fpu_return+0x5b/0xe0
> Apr 29 12:10:54 myhost kernel:  ? do_syscall_64+0x245/0x5e0
> Apr 29 12:10:54 myhost kernel:  ? ksys_write+0xcd/0xf0
> Apr 29 12:10:54 myhost kernel:  ? do_syscall_64+0xbe/0x5e0
> Apr 29 12:10:54 myhost kernel:  ? irqentry_exit+0x6e/0x570
> Apr 29 12:10:54 myhost kernel:  ? __irq_exit_rcu+0x3d/0xe0
> Apr 29 12:10:54 myhost kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Apr 29 12:10:54 myhost kernel: RIP: 0033:0x7f2c02368d3b
> Apr 29 12:10:54 myhost kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 =
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 =
00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 2=
8 00 00
> Apr 29 12:10:54 myhost kernel: RSP: 002b:00007fff14e31360 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000010
> Apr 29 12:10:54 myhost kernel: RAX: ffffffffffffffda RBX: 00000000c018aec=
0 RCX: 00007f2c02368d3b
> Apr 29 12:10:54 myhost kernel: RDX: 00007fff14e314d0 RSI: ffffffffc018aec=
0 RDI: 0000000000000015
> Apr 29 12:10:54 myhost kernel: RBP: 000055e177b41000 R08: 000000000000004=
0 R09: 0000000000000000
> Apr 29 12:10:54 myhost kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 00007fff14e314d0
> Apr 29 12:10:54 myhost kernel: R13: 0000000000000000 R14: 000000000000000=
8 R15: 000055e177b410b0
> Apr 29 12:10:54 myhost kernel:  </TASK>

Any ideas here?

Regards,
Salvatore
