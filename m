Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AA370AFD
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307817; cv=none; b=lUZsxOLseZfjxSjE+o9avaJlTOhgj0Ss26bFKGaueEwvz4FqoGOsryIMG9wpdN7NBP1/udCy9f+HeE4E8tqTfrCDZAhxq167ZLOvSH/y3BbIdsj+/E5J8Pj+CY1gUVheRHnympAichMRzrFyhWVDjr16Kjzh5nTX8Ih4r6TZ0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307817; c=relaxed/simple;
	bh=Ct8VAHl/hM82xbdX47l8wyLUbt6IPB8r2AdW6zNCCa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ti7PFjlmz3Xx0lYw9/5d2yAw1W/jbvI/NuNHPnOmqXnSlc8vgsbxLbhZ0HjGMvTEQhbYtA2Ak7kL5QWPpQRJ7E3Rgs1iQqXZ3tFi4SJIOUyj91PT/0FKu+u7prT1NKx6jOln9pFt9sa9k9oVQankWeOAhYGVRwEBvykFq9xwaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bXx46Z1i; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bXx46Z1i"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hzjv64L8nzMlSt;
	Tue, 06 Oct 2026 19:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791307810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GV8jgIcB8pZm9MBhFcBJ5WcCPuYfQK8KFlSYKQxEF8U=;
	b=bXx46Z1ig/eP8n6dxqpbndXms9m05E4Cnl0e4mbpEle8VNQqc6Z8SeBQQNnx7VFwxLTdTJ
	ty1u+3fAmX867Vul7K4OBz/wLjwYTgWzg1Si64S4VPun362wzud9n8Dl8QlcCjqnC2k5h1
	8Xi+npMgF8nh1T/zLaGM7eJWtRU1TspNl1Vde+HwDCB9N9WsEP+oijPhspyrTxX79zlmeF
	r32121Z6xzArPgeSIVW2MAC7giQ20/Wey/z5Yn4C290DCXV1UphKEry9wRGQZE/D457op3
	+nJ128EhJKx0dek5r9rG8r/mh6prpSrNfF7UgWI3/Si/e7Mfpn2y1NYGDez8Sg==
Date: Tue, 6 Oct 2026 19:29:55 +0200
From: SimonP <simonp.git@mailbox.org>
To: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Subject: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest triggers
 UBSAN: array-index-out-of-bounds
Message-ID: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: c9298bf3598b253f42f
X-MBO-RS-META: wh3o18h5yxnf1t8nc7hd8woui8kbfyms

Hello,

See subject. Happens in permission_fault() on line:

	fault =3D (mmu->permissions[index] >> pte_access) & 1;

Some output from a printk I added, not spammed but keeps happening:

kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1

Full dmesg spew below. The guest works but this seems not great. Not
fixed as of 7.2.9.

I bisected the bad commit to 687ee95c1b6d7509a25bbc661e62801aa06cc2ae
but as this is just an enablement commit it seems more likely that
something is incomplete or went wrong in other commits in the series.

Regards,
Simon

dmesg:

kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
kernel: index 34 is out of range for type 'u16 [16]'
kernel: CPU: 7 UID: 64055 PID: 13695 Comm: CPU 12/KVM Not tainted 7.2.9+deb=
14-amd64-simonp #1 PREEMPT(lazy)  Debian 7.2.9-1sp=20
kernel: Hardware name: To Be Filled By O.E.M. X570 Taichi/X570 Taichi, BIOS=
 P5.80 03/24/2026
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x4d/0x70
kernel:  ubsan_epilogue+0x5/0x2b
kernel:  __ubsan_handle_out_of_bounds.cold+0x4e/0x58
kernel:  paging64_walk_addr_generic+0xc24/0xce0 [kvm]
kernel:  paging64_page_fault+0x84/0x9a0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_paging64_page_fault+0x10/0x10 [kvm]
kernel:  kvm_mmu_do_page_fault+0x140/0x240 [kvm]
kernel:  kvm_mmu_page_fault+0x9c/0x880 [kvm]
kernel:  ? kvm_vcpu_read_guest+0x52/0xa0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? nested_svm_merge_msrpm+0xc8/0x1c0 [kvm_amd]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __svm_vcpu_run+0x145/0x240 [kvm_amd]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? rcu_note_context_switch+0x57/0x530
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  npf_interception+0xb2/0x2c0 [kvm_amd]
kernel:  kvm_arch_vcpu_ioctl_run+0x69b/0x20e0 [kvm]
kernel:  kvm_vcpu_ioctl+0x367/0xac0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? select_task_rq_fair+0x9b5/0x2670
kernel:  __x64_sys_ioctl+0xb9/0x100
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  do_syscall_64+0xdd/0x5f0
kernel:  ? __smp_call_single_queue+0xd6/0x190
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? ttwu_queue_wakelist+0x144/0x230
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? try_to_wake_up+0x300/0x8b0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? kvm_on_user_return+0x1e/0xe0 [kvm]
kernel:  ? __x64_sys_ioctl+0xd4/0x100
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? wake_up_q+0x4c/0xa0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? futex_wake+0x117/0x270
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x116/0x5f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __seccomp_filter+0x86/0x6e0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x31e/0x5f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? write_ibpb+0x21/0x50
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x94/0x5f0
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x7f38d6202f5b
kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d=
 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
kernel: RSP: 002b:00007f359d9fe280 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
kernel: RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f38d6202f5b
kernel: RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000003a
kernel: RBP: 00005575017a2550 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
kernel:  </TASK>
kernel: ---[ end trace ]---
kernel: ------------[ cut here ]------------
kernel: WARNING: arch/x86/kvm/mmu.h:227 at paging64_walk_addr_generic+0x8e4=
/0xce0 [kvm], CPU#7: CPU 12/KVM/13695
kernel: Modules linked in: vhost_net vhost vhost_iotlb tap tun nft_masq nf_=
conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_tftp nft_fib_inet =
nft_fib_ipv4 nft_fib_ipv6 bridge nft_fib stp llc nft_reject_inet nf_reject_=
ipv4 nf_reject_ipv6 snd_seq_dummy nft_reject snd_hrtimer nft_ct snd_seq snd=
_seq_device nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
 nf_tables uinput btrfs libblake2b nfsd auth_rpcgss nls_ascii nfs_acl nls_c=
p437 lockd raid6_pq xor vfat grace fat binfmt_misc xfs sunrpc snd_hda_codec=
_alc882 amdgpu snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_code=
c_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl intel_rapl_msr intel_rap=
l_common drm_buddy vfio_pci amdxcp vfio_pci_core drm_ttm_helper edac_mce_am=
d vfio_iommu_type1 ttm jc42 vfio drm_exec snd_intel_dspcfg drm_panel_backli=
ght_quirks kvm_amd snd_hda_codec gpu_sched drm_suballoc_helper ee1004 wmi_b=
mof snd_hda_core joydev kvm evdev igb drm_display_helper snd_hwdep irqbypas=
s i2c_algo_bit snd_pcm cec dca rapl sg pcspkr k10temp
kernel:  snd_timer video snd soundcore i2c_piix4 button wmi i2c_smbus nvme_=
fabrics efi_pstore configfs ext4 crc16 mbcache jbd2 crc32c_cryptoapi dm_cry=
pt hid_generic sd_mod usbhid hid ahci libahci xhci_pci nvme libata xhci_hcd=
 nvme_core nvme_keyring scsi_mod usbcore nvme_auth sp5100_tco scsi_common c=
cp usb_common watchdog dm_mirror dm_region_hash dm_log dm_mod nct6775 nct67=
75_core ntsync hwmon_vid i2c_dev msr efivarfs autofs4 aesni_intel gf128mul
kernel: CPU: 7 UID: 64055 PID: 13695 Comm: CPU 12/KVM Not tainted 7.2.9+deb=
14-amd64-simonp #1 PREEMPT(lazy)  Debian 7.2.9-1sp=20
kernel: Hardware name: To Be Filled By O.E.M. X570 Taichi/X570 Taichi, BIOS=
 P5.80 03/24/2026
kernel: RIP: 0010:paging64_walk_addr_generic+0x8e4/0xce0 [kvm]
kernel: Code: f9 1f 0f 87 d6 ad 01 00 44 89 c2 d3 ea 23 54 24 18 83 e2 03 8=
9 d1 f7 d9 83 e1 20 83 c9 01 85 d2 0f 95 c2 09 d0 e9 3f fe ff ff <0f> 0b e9=
 26 fe ff ff 8b 44 24 20 45 8b 7e 04 4c 89 64 24 18 4c 89
kernel: RSP: 0018:ffffc98d85b9b5f0 EFLAGS: 00010202
kernel: RAX: 0000000000000000 RBX: 60000001274000e3 RCX: 000000000000000b
kernel: RDX: 0000000000000022 RSI: 0000000000000001 RDI: ffffffffa5ad965d
kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffff892f725bd5f0
kernel: R10: 00000000274000e3 R11: e000000100000023 R12: ffff892f725bd1d8
kernel: R13: ffff892f725bd760 R14: ffffc98d85b9b6b8 R15: 0000000000118c71
kernel: FS:  00007f359d9ff6c0(0000) GS:ffff893b97d6b000(0000) knlGS:0000000=
000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 00000001c382b000 CR4: 0000000000f50ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  paging64_page_fault+0x84/0x9a0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_paging64_page_fault+0x10/0x10 [kvm]
kernel:  kvm_mmu_do_page_fault+0x140/0x240 [kvm]
kernel:  kvm_mmu_page_fault+0x9c/0x880 [kvm]
kernel:  ? kvm_vcpu_read_guest+0x52/0xa0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? nested_svm_merge_msrpm+0xc8/0x1c0 [kvm_amd]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __svm_vcpu_run+0x145/0x240 [kvm_amd]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? rcu_note_context_switch+0x57/0x530
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  npf_interception+0xb2/0x2c0 [kvm_amd]
kernel:  kvm_arch_vcpu_ioctl_run+0x69b/0x20e0 [kvm]
kernel:  kvm_vcpu_ioctl+0x367/0xac0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? select_task_rq_fair+0x9b5/0x2670
kernel:  __x64_sys_ioctl+0xb9/0x100
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  do_syscall_64+0xdd/0x5f0
kernel:  ? __smp_call_single_queue+0xd6/0x190
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? ttwu_queue_wakelist+0x144/0x230
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? try_to_wake_up+0x300/0x8b0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? kvm_on_user_return+0x1e/0xe0 [kvm]
kernel:  ? __x64_sys_ioctl+0xd4/0x100
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? wake_up_q+0x4c/0xa0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? futex_wake+0x117/0x270
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x116/0x5f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __x64_sys_futex+0x12a/0x220
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __seccomp_filter+0x86/0x6e0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x31e/0x5f0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? write_ibpb+0x21/0x50
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? do_syscall_64+0x94/0x5f0
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x7f38d6202f5b
kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d=
 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
kernel: RSP: 002b:00007f359d9fe280 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
kernel: RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f38d6202f5b
kernel: RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000003a
kernel: RBP: 00005575017a2550 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
kernel:  </TASK>
