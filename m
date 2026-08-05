Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE58472531;
	Wed,  5 Aug 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933326; cv=none; b=UySQRIZbqUGVBDInxjgQ65oT5rCh8NuZ5I2NyJ/p7V8Jz3YPOm7YVO2Hw/YTJDLmmPTwmNFKl9QVPkHGAVOgl54CoQVlyv2DE2z/zWpJv4wuduE9UCfv5/QUiHYh1Yxs7Q81OZv6qv7C00pYOx48aYun5OXJy3+FiRamnwIazJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933326; c=relaxed/simple;
	bh=QUqQLk8ZN2QZfGxm+zisma9Q+a+3VA1lODRYtKTfE5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCDzdhNERnUkWIyVxEtUHnL+Za6J2HwWOCwmsx98BE3Yj7Ifai1H4pG/+Q9/2Pm7k026fVnvMYnVX5angNoLlXkCByDqjzTNJIPim96Lf469gtU4j4mC1y+RkIXfD8qWdzJ5zFkEldfy5ZquMh7cAXVdNVJ5v+i/Jju27UylrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8577D43D8A;
	Wed, 05 Aug 2026 14:35:15 +0200 (CEST)
Message-ID: <bdb4a6dc-1d81-4cb4-802f-f9638009d6c5@proxmox.com>
Date: Wed, 5 Aug 2026 14:35:13 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
References: <20260505195226.563317-1-pbonzini@redhat.com>
Content-Language: en-US
From: Jonas Theisen <j.theisen@proxmox.com>
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1785933300669

Hello everyone,

we ran into an issue we suspect is indirectly related to the patches 
enabling
MBEC support in the current 7.2-rc6.  We first encountered the issue on 
Proxmox
VE, where we have applied the MBEC patches to our downstream kernel, but all
results below are obtained using an unpatched kernel 7.2-rc6 from kernel.org
and unpatched upstream QEMU.

When using Windows 11 / Server 2022 / Server 2025 with Virtualization-Based
Security (VBS) enabled on an Intel CPU with MBEC support and CPU type 
host, the
VM will occasionally freeze and get stuck at 100% vCPU usage. After some
minutes to hours the VM usually un-freezes itself.  A reliable trigger 
for us
is the free software LatencyMon [1]. As soon as the trace is started inside
the software the VM will freeze within seconds.

We have found several potential workarounds:
- Removing the CPU flags 'vmx-apicv-register' or 'vmx-apicv-vid' apparently
   removes the support for APICv inside Windows and we haven't seen a 
freeze in
   such a VM yet.
- Enabling the Hyper-V enlightenment 'hv-evmcs' also removes the 
reported APICv
   support and runs stable so far.
- Disabling MBEC by removing the CPU flag "vmx-mbec" also prevents the 
freezes
   but as expected the VM is much slower overall

To check MBEC/APICv support inside Windows we ran the following command [2]:

(Get-CimInstance -ClassName Win32_DeviceGuard -Namespace 
root\Microsoft\Windows\DeviceGuard).AvailableSecurityProperties

And check whether MBEC/GMET (value 7) and/or APICv (value 8) support are 
present:

- MBEC disabled, VBS disabled: 8 (APICv)           - no freezes
- MBEC disabled, VBS enabled:  none of the above   - no freezes
- MBEC enabled,  VBS disabled: 7 (MBEC), 8 (APICv) - no freezes
- MBEC enabled,  VBS enabled:  7 (MBEC), 8 (APICv) - freezes

Removing the APICv flags or enabling the hv-evmcs enlightenment (see above)
makes the 8 in the AvailableSecurityProperties output disappear and 
fixes the
freezes for us. This is why we suspect that enabling MBEC support indirectly
causes Windows to use APICv if VBS is enabled and somehow trigger the 
observed
freezes.

Any idea how to troubleshoot this further? Happy to provide more debug
information, just let me know.

We can reproduce the freezes on 7.2-rc6 with QEMU 11.0.3 on
an Intel Core Ultra 7 255H with the following commandline:
'/root/qemu-11.0.3/build/qemu-system-x86_64 \
   -enable-kvm \
   -name win25-440fx \
   -chardev 
'socket,id=qmp,path=/var/run/qemu-server/117.qmp,server=on,wait=off' \
   -mon 'chardev=qmp,mode=control' \
   -pidfile /var/run/qemu-server/117.pid \
   -smbios 'type=1,uuid=30769fc5-9e9a-44bb-b232-9e67892a12b8' \
   -blockdev 
'{"driver":"raw","file":{"driver":"file","filename":"/usr/share/pve-edk2-firmware//OVMF_CODE_4M.fd"},"node-name":"pflash0","read-only":true}' 
\
   -blockdev 
'{"cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-117-disk-0","node-name":"e252459adb2974f3ea2c089ceda6c1a","read-only":false},"node-name":"drive-efidisk0","read-only":false,"size":540672}' 
\
   -smp '8,sockets=1,cores=8,maxcpus=8' \
   -vnc 'unix:/var/run/qemu-server/117.vnc,password=on' \
   -cpu 'host,-cet-ibt,-cet-ss,hv_relaxed' \
   -m 8192 \
   -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
   -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
   -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
   -blockdev 
'{"cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-117-disk-1","node-name":"e2a0877c37c7b22323a318bd3346607","read-only":false},"node-name":"drive-scsi0","read-only":false}' 
\
   -device 
'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,device_id=drive-scsi0,bootindex=100,write-cache=on' 
\
   -rtc 'driftfix=slew,base=localtime' \
   -machine 
'pflash0=pflash0,pflash1=drive-efidisk0,hpet=off,type=pc-i440fx-11.0'
'

Sidenote - likely unrelated to the freezes: Removing the Hyper-V 
enlightenment
'hv_relaxed' still causes the VM to freeze but instead of staying frozen for
minutes to hours the VM will throw a BSOD with "CLOCK_WATCHDOG_TIMEOUT 
(0x101)"
or "SYNTHETIC_WATCHDOG_TIMEOUT (0x1CA)" after around one minute and reboot
after that.

Thank you!

Best regards
Jonas

[1] https://www.resplendence.com/latencymon
[2] 
https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security


