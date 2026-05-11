Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371B3630A9;
	Mon, 11 May 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497657; cv=none; b=PlD78KzGEw3SyrSK/ZLRX7hI500Ac/JbYkZKo8Oj7MFCdCqEbXaxk7K7wU+eBxi69gVTHHpbX8+3NJIYQT0VD4KzwrWLPnXvAXhPfwqeyd/yETM6RA5ZpeweqaVdVx5+i+fACO2RWHY5nFRDHmPtNydcbpGf3ZUofBVkCCHNEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497657; c=relaxed/simple;
	bh=RxzH+EXWg7sNkh+Jw4RKdgjG2euIJI/hXWLWOnjuMJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVPmxjRjUO38yTRMOG7K69MSbRUYP+iljvJEtgKmy9SmPZPxKC3CPLf2645f0IbJXTuFvgHukj84mlWNvkJobbwti3aynGaYp26FAhbsoTqkD6GVYyG0YxSE0grc7PXACNcnwHh4bklE+llDFKSW3ticXEl/u3dVhouy1Us/tuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7C714A0FCF;
	Mon, 11 May 2026 13:07:34 +0200 (CEST)
Message-ID: <8ebbfb3d-69a0-42d0-83cd-78e163e3acdf@proxmox.com>
Date: Mon, 11 May 2026 13:07:33 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: jon@nutanix.com
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <251c6f2c-6a6b-4a7b-b0d6-330611bb12c6@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <251c6f2c-6a6b-4a7b-b0d6-330611bb12c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778497542140

is that enough?

dmesg | grep -A 50 "soft lockup - CPU#11"

[ 5565.326572] watchdog: BUG: soft lockup - CPU#11 stuck for 28s! [CPU 0/KVM:16105]
[ 5565.326576] Modules linked in: tcp_diag(E) inet_diag(E) veth(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) nfs(E) lockd(E) grace(E) netfs(E) ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) sunrpc(E) nf_tables(E) softdog(E) bonding(E) tls(E) binfmt_misc(E) nfnetlink_log(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) intel_ifs(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) cxl_pci(E) cxl_mem(E) kvm_intel(E) acpi_power_meter(E) ipmi_ssif(E) cxl_acpi(E) cxl_port(E) cxl_pmem(E) kvm(E) pmt_telemetry(E) dax_hmem(E) pmt_discovery(E) irqbypass(E) pmt_class(E) intel_sdsi(E) bnxt_re(E) cxl_core(E) aesni_intel(E) ib_uverbs(E) gf128mul(E) isst_if_mmio(E) isst_if_mbox_pci(E) fwctl(E) rapl(E) cmdlinepart(E) intel_cstate(E) einj(E) pcspkr(E) wmi_bmof(E) spi_nor(E) iaa_crypto(E) isst_if_common(E) ib_core(E) 
intel_vsec(E) mei_me(E) ast(E) mtd(E) spd5118(E)
[ 5565.326599]  i2c_algo_bit(E) mei(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) joydev(E) input_leds(E) mac_hid(E) sch_fq_codel(E) msr(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E) efi_pstore(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) libblake2b(E) raid6_pq(E) xor(E) hid_generic(E) usbmouse(E) usbkbd(E) usbhid(E) hid(E) cdc_ether(E) usbnet(E) mii(E) uas(E) usb_storage(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) nvme(E) nvme_core(E) xhci_pci(E) i40e(E) nvme_keyring(E) i2c_i801(E) idxd(E) tg3(E) ahci(E) i2c_mux(E) libie(E) idxd_bus(E) spi_intel_pci(E) bnxt_en(E) nvme_auth(E) libie_adminq(E) xhci_hcd(E) i2c_smbus(E) spi_intel(E) libahci(E) i2c_ismt(E) wmi(E) pinctrl_emmitsburg(E)
[ 5565.326618] CPU: 11 UID: 0 PID: 16105 Comm: CPU 0/KVM Tainted: G            EL      7.1.0-rc2-v6-mbec-gmet-00028-g1e3b074acc33 #24 PREEMPT(lazy)
[ 5565.326620] Tainted: [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
[ 5565.326620] Hardware name: ****, BIOS 3001 07/03/2025
[ 5565.326621] RIP: 0010:kvm_arch_vcpu_ioctl_run+0x78d/0x18e0 [kvm]
[ 5565.326680] Code: 07 00 48 83 bb 28 08 00 00 00 0f 85 69 0a 00 00 0f 1f 44 00 00 65 c6 05 08 d7 08 c7 01 c6 83 e2 0a 00 00 01 fb 0f 1f 44 00 00 <48> 83 83 48 19 00 00 01 fa 0f 1f 44 00 00 c6 83 e2 0a 00 00 00 0f
[ 5565.326681] RSP: 0018:ff6afb0ed454b9e0 EFLAGS: 00000246
[ 5565.326682] RAX: 0000000000000000 RBX: ff2a147c1758a480 RCX: 0000000000000000
[ 5565.326683] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 5565.326683] RBP: ff6afb0ed454ba90 R08: 0000000000000000 R09: 0000000000000000
[ 5565.326684] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 5565.326684] R13: ff2a147c12163000 R14: 0000000000000000 R15: ff2a147c20d2b140
[ 5565.326685] FS:  00007503727ef6c0(0000) GS:ff2a147bf748a000(0000) knlGS:fffff8013ee33000
[ 5565.326685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5565.326686] CR2: 00007fffffff0000 CR3: 00000020948ed006 CR4: 0000000000f73ef0
[ 5565.326687] PKRU: 55555554
[ 5565.326687] Call Trace:
[ 5565.326688]  <TASK>
[ 5565.326689]  ? trace_event_buffer_reserve+0xa5/0xe0
[ 5565.326692]  ? trace_event_raw_event_kvm_userspace_exit+0x6c/0xc0 [kvm]
[ 5565.326727]  kvm_vcpu_ioctl+0x312/0xba0 [kvm]
[ 5565.326762]  ? __rb_reserve_next.constprop.0+0x5c/0x420
[ 5565.326765]  ? ring_buffer_lock_reserve+0x155/0x410
[ 5565.326767]  __x64_sys_ioctl+0xa5/0x100
[ 5565.326769]  x64_sys_call+0x103b/0x2390
[ 5565.326771]  do_syscall_64+0xe6/0x14c0
[ 5565.326774]  ? trace_event_buffer_reserve+0xa5/0xe0
[ 5565.326775]  ? trace_event_raw_event_kvm_userspace_exit+0x6c/0xc0 [kvm]
[ 5565.326807]  ? kvm_vcpu_ioctl+0x2a7/0xba0 [kvm]
[ 5565.326841]  ? trace_event_buffer_reserve+0xa5/0xe0
[ 5565.326842]  ? trace_event_raw_event_kvm_userspace_exit+0x6c/0xc0 [kvm]
[ 5565.326874]  ? __x64_sys_ioctl+0xbf/0x100
[ 5565.326875]  ? kvm_on_user_return+0x4a/0x90 [kvm]
[ 5565.326916]  ? fire_user_return_notifiers+0x37/0x70
[ 5565.326918]  ? do_syscall_64+0x396/0x14c0
[ 5565.326920]  ? do_syscall_64+0x396/0x14c0
[ 5565.326922]  ? __x64_sys_ioctl+0xbf/0x100
[ 5565.326923]  ? kvm_on_user_return+0x4a/0x90 [kvm]
[ 5565.326962]  ? fire_user_return_notifiers+0x37/0x70
[ 5565.326963]  ? do_syscall_64+0x396/0x14c0
[ 5565.326965]  ? kvm_on_user_return+0x4a/0x90 [kvm]
[ 5565.327002]  ? fire_user_return_notifiers+0x37/0x70
[ 5565.327004]  ? do_syscall_64+0x396/0x14c0
[ 5565.327005]  ? do_syscall_64+0x396/0x14c0
[ 5565.327007]  ? do_syscall_64+0x396/0x14c0
[ 5565.327008]  ? do_syscall_64+0x396/0x14c0
[ 5565.327009]  ? do_syscall_64+0x9b/0x14c0
[ 5565.327011]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 5565.327012] RIP: 0033:0x75037650f91b


On 5/11/26 12:54 PM, Paolo Bonzini wrote:
> On 5/11/26 12:53, David Riley wrote:
>>
>> watchdog: CPU11: Watchdog detected hard LOCKUP on cpu 11
>> watchdog: BUG: soft lockup - CPU#11 stuck for 28s [CPU 0/KVM:16105]
>
> What is the backtrace here?
>
> Thanks,
>
> Paolo
>
>

