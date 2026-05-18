Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE08369985
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111840; cv=none; b=psyC7dDT8SytbHb9NpSSM6bRTXwntclyrUKfzdBLJcus9a9orl+AOT3W+8nzsuvQ2RilR8vgj6xLURHKKl9RAQuWmifyBzX32WSa7d8KrPJXu8m7hwBg9+SnA4FWeJcCb16iIyBWuvHKbP89qqr6O/PizzkupsOPWkgouEnEya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111840; c=relaxed/simple;
	bh=6ViipJtYaWE7X+RGIT5lJHgo9GTgwIzjZKTQCqd+9cs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFwCE8TJf4f+Y0OCNpsFi7PsEJeQ+WCXP1L3JKeC9tbjD8PxhEJG6xR9GEJP1Jr8I4da6FnWKQA0kuQgXZKORDeBy0mhxw/HOAFnSWP3z4GrvotGTyTRcv6U5jMlhDEJZROpR89Qlhi1aBlCjIprQN4WhwWk9yqzpfthZ8W/NHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEZbYKLt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEZbYKLt"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c4772950so980604a12.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779111838; x=1779716638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSXlK1q/LjuOaKSWj1DPnaYKmzVSh2Oay23bhDB4nn4=;
        b=iEZbYKLt6nqfpveu7Y6HdgC8Y6spBNTsIHlMDzdnatLCPj3soGCwtEYMz6TcNg8lq0
         ybUDDEOQc3BfiRkaUZWKVoL6CC+5vBrALMBeBhdLhF4d0v4L8UA40ARQUcwSCugGzYIy
         /TqdpNwOuAwWwCA3tooDXjtdmDJUugw2IsEZk+X8L02pptDGra3fTGsAI7yYdi2gKXUN
         5a17CJWrmHpFF4puwv5UZj//p0IaCRsDYG8omVN6Co5Pl/HA3T6/uOUubEH30flrDn/c
         ejKs9ZVDbjG9MnEd0IUz6gGGPGxBvX+Q4s6BzxYcADhWZoHeNccGcsK0OeqpZt9h+OLY
         FsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111838; x=1779716638;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSXlK1q/LjuOaKSWj1DPnaYKmzVSh2Oay23bhDB4nn4=;
        b=NM2FJn1QvKMnF9sGgrlOxHUJ7g/at4CR0SSRaScjEgTQIUwkr7D6kWlRq/NA7aoEXj
         lTzjhyQECqDJEYXCEhnxhSlAku3udBzKnETzhu5Kl4Zx871WqsieDTVUbKdejHVtRVVh
         ofBTbBPoaFu7TIDTzBDv0mr4yi+LhKUiIFQECxYc+H61WnqJb3z0QPA3ADO5d66e8eLz
         6foyHDdrFT10quQxE/Zv7eFHNoj45+2yYjj/GivVuv76gdJPS0FjehbqTmmjQxB9KUSh
         2yhYIzLIvizXn9FI0/4+Z50jE7EKOtdAWgyFOVKWyb5+C/kl4TrVP+Rw2WfespZT8SMq
         O44w==
X-Forwarded-Encrypted: i=1; AFNElJ99T+Ns/DTd2e82itQy+YTnaDmymeIBn9kI8QwW75SpGIonIMIBGA9F4jBLBqRb0OnG6GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/Tb38L/HRvmVaFxlM9PcLayVaaBL8ee9iFeoGQ4ItlzSuYFn
	Lf+S7aeCDPayJMVeOcX2ulKjaIkOzjm4DrYliMHUikkopEo9+3GqjFkYVv4DY2n5SzwgfB2Zl8P
	RnQQhFQ==
X-Received: from pghx12.prod.google.com ([2002:a63:f70c:0:b0:c79:7415:3dd2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0d:b0:3b2:b1e9:f1f2
 with SMTP id adf61e73a8af0-3b2b1eac3edmr612576637.4.1779111837952; Mon, 18
 May 2026 06:43:57 -0700 (PDT)
Date: Mon, 18 May 2026 13:43:57 +0000
In-Reply-To: <177902420697.2035014.8796825668567298024@eldamar.lan>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
 <177902420697.2035014.8796825668567298024@eldamar.lan>
Message-ID: <agsXnbjjKdrq8e-T@google.com>
Subject: Re: Bug#1135235: linux-image-6.19.13+deb14-amd64: Reoccuring host
 crash "Invalid SPTE change" with gaming win kvm/qemu guest and device passthrough
From: Sean Christopherson <seanjc@google.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Maximilian Senftleben <kernel@0in.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 1135235@bugs.debian.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026, Salvatore Bonaccorso wrote:
> Control: forwwarded -1 https://lore.kernel.org/all/177902420697.2035014.8=
796825668567298024@eldamar.lan
>=20
> Hi
>=20
> Maximilian Senftleben reported the following in Debian (cf.
> https://bugs.debian.org/1135235), it should be noted while Maximilian
> uses the looking-glass application (which is acompanied with dkms
> modules, they are not loaded and do not tain the kernel). Do you have
> an idea how to debug this?
>=20
> On Wed, Apr 29, 2026 at 09:17:14PM +0200, Maximilian Senftleben wrote:
> > Package: src:linux
> > Version: 6.19.13-1
> > Severity: important
> >=20
> > Dear Maintainer,
> >=20
> > - I have a Windows kvm/qemu guest that uses device passthrough for my G=
PU.
> > - Sometimes while playing the host system crashes/freezes, this only ha=
ppens
> > during load/gaming, and sometimes 1-2 times a day, sometimes not at all=
.
> >=20
> >=20
> > System:
> > Linux myhost 6.19.13+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.19.13-=
1
> > (2026-04-18) x86_64 GNU/Linux
> >=20
> > CPU:
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 183
> > model name      : Intel(R) Core(TM) i5-14400
> > [...]
> >=20
> > Apr 29 12:10:33 myhost kernel: kvm: Invalid SPTE change: cannot replace=
 a present leaf
> >                                        SPTE with another present leaf S=
PTE mapping a
> >                                        different PFN!
> >                                        as_id: 0 gfn: 80ec33 old_spte: 8=
60000aae3d00bc8 new_spte: 86000009e3d00b77 level: 1
> > Apr 29 12:10:33 myhost kernel: ------------[ cut here ]------------
> > Apr 29 12:10:33 myhost kernel: kernel BUG at arch/x86/kvm/mmu/tdp_mmu.c=
:600!
> > Apr 29 12:10:33 myhost kernel: Oops: invalid opcode: 0000 [#1] SMP NOPT=
I
> > Apr 29 12:10:33 myhost kernel: CPU: 7 UID: 1000 PID: 8419 Comm: CPU 2/K=
VM Not tainted 6.19.13+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.19.13-1=20
> > Apr 29 12:10:33 myhost kernel: Hardware name: Micro-Star International =
Co., Ltd. MS-7D96/MAG B760 TOMAHAWK WIFI (MS-7D96), BIOS A.B0 10/07/2024
> > Apr 29 12:10:33 myhost kernel: RIP: 0010:handle_changed_spte.cold+0x1d/=
0x84 [kvm]
> > Apr 29 12:10:33 myhost kernel: Modules linked in: vhost_net vhost vhost=
_iotlb tap tun rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQ=
UERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables=
 nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables =
bridge stp llc sunrpc uinput qrtr cmac algif_hash algif_skcipher af_alg bne=
p dm_crypt hid_corsair joydev snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl s=
nd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_=
intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda=
 soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_hda_codec_intelhdmi s=
nd_sof snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common iwlmvm snd_sof_u=
tils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks intel_uncore_f=
requency soundwire_generic_allocation intel_uncore_frequency_common snd_soc=
_sdw_utils snd_soc_acpi snd_hda_codec_alc662 x86_pkg_temp_thermal crc8 inte=
l_powerclamp snd_hda_codec_realtek_lib uvcvideo soundwire_bus coretemp mac8=
0211
> > Apr 29 12:10:33 myhost kernel:  snd_hda_codec_generic videobuf2_vmalloc=
 snd_soc_sdca uvc videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_soc_avs=
 videodev snd_soc_hda_codec kvm_intel snd_hda_intel snd_usbmidi_lib snd_hda=
_ext_core snd_rawmidi snd_hda_codec videobuf2_common snd_seq_device nls_asc=
ii mc hid_generic snd_soc_core nls_cp437 libarc4 iTCO_wdt snd_hda_core vfat=
 intel_pmc_bxt kvm fat mei_hdcp mei_pxp spd5118 snd_intel_dspcfg iTCO_vendo=
r_support snd_compress iwlwifi snd_intel_sdw_acpi watchdog snd_pcm_dmaengin=
e snd_hwdep rapl snd_pcm intel_cstate r8169 battery snd_timer cfg80211 inte=
l_uncore wmi_bmof mxm_wmi snd mei_me realtek pcspkr i2c_i801 i2c_smbus soun=
dcore mei fan btusb intel_pmc_core btmtk uas btrtl btbcm btintel pmt_teleme=
try serial_multi_instantiate usb_storage bluetooth pmt_discovery pmt_class =
intel_pmc_ssram_telemetry acpi_tad acpi_pad usbhid ecdh_generic hid button =
evdev sg rfkill binfmt_misc dm_mod efi_pstore nfnetlink xe drm_ttm_helper d=
rm_suballoc_helper gpu_sched drm_gpuvm drm_exec configfs drm_gpusvm_helper =
ext4
> > Apr 29 12:10:33 myhost kernel:  crc16 mbcache jbd2 crc32c_cryptoapi i91=
5 drm_client_lib sd_mod i2c_algo_bit drm_buddy ttm drm_display_helper ahci =
drm_kms_helper libahci xhci_pci libata xhci_hcd drm nvme nvme_core usbcore =
scsi_mod nvme_keyring cec nvme_auth video ghash_clmulni_intel hkdf rc_core =
scsi_common intel_vsec usb_common wmi pinctrl_alderlake vfio_pci vfio_pci_c=
ore irqbypass vfio_iommu_type1 vfio parport_pc lp ppdev parport i2c_dev msr=
 efivarfs autofs4 aesni_intel
> > Apr 29 12:10:33 myhost kernel: ---[ end trace 0000000000000000 ]---
> > Apr 29 12:10:33 myhost kernel: kvm: get_mmio_spte: reserved bits set on=
 MMU-present spte, addr 0x80ec3098c, hierarchy:
> > Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x8000000109193907 =
level =3D 4, rsvd bits =3D 0xfff80000000f8
> > Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x80000008d8b33907 =
level =3D 3, rsvd bits =3D 0xfff8000000078
> > Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x8000000371e37907 =
level =3D 2, rsvd bits =3D 0xfff8000000078
> > Apr 29 12:10:33 myhost kernel: kvm: ------ spte =3D 0x86000004e3cfdb26 =
level =3D 1, rsvd bits =3D 0xfff8000000000
> > Apr 29 12:10:33 myhost kernel: ------------[ cut here ]------------

Odds are very good this is due to host memory corruption, and is not a bug =
in
KVM's MMU.  We (Google) had a period of time where our kernel was triggerin=
g stack
overflows if a networking IRQ hit at just the right/wrong time, and wheneve=
r the
overflow wandered into KVM page tables, it would result in failures like th=
ese.
I got quite familiar with the signature :-)

If you aren't already, can you try running with CONFIG_VMAP_STACK=3Dy?  Sta=
ck
overflow doesn't seem likely in this case since the gfn would put the SPTE =
in the
middle of the page table, but it's easy enough to rule out.

The other thing to try would be to run with CONFIG_KASAN=3Dy.  That might m=
ake your
gaming quite miserable, but if this is indeed due to a rogue write, it's th=
e best
shot for catching the culprit.

Or as Paolo suggested, you could try bisecting.
