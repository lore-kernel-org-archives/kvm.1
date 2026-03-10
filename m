Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869830B50C
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158998; cv=pass; b=UH3LNPVy/yZ5WcWsQypj/nJdMw7r4pbmX5G1iYQX+KNY2dy+4CkkCiL2K3ojiIgDQ/Q94+8JbeG9+CFhS8yyADscSw1wBl9zN8KjdwbNZ4AR6HaR1k/51rfnkWzkeFGNsVtxPnWPZ37a49w02tyEiNwL0riKqtGdPwHN/k8srGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158998; c=relaxed/simple;
	bh=N+o187iSo1YBIU0n5tvU/NwrGRCtCAxMem7EBBUpH/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1l/Bp1h9LbNVIArQG7/+8anUmUKNDl35n9tc8BRpc+dCtF1hhxmitBNfmnd20uN24BesukL89M1NBsI6kzKEOTMjmC6Gl5l2mrk9ciIHqHqxoCNvGvz7MlLu//BOacQIBF8SAiB0AQn6plN1vOcaqBaagKH471q9CVOusoHcT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMx86ZC1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Csr5eGz+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMx86ZC1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Csr5eGz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773158995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
	b=KMx86ZC1i1ufiTv3Fp3UbP4iHfwBVT0TABqoMT34qqIFw3kCoj4MnBSXBqrx7ZWZhfi0F5
	FIVSEanIk+/en/KHW5dVgikxQPOOyp+uA6CePqeHN++stFeK9qSyfDvJJO/epqJmd0DCBs
	LpdVMD5gKLhmFOxkKx6Tuc8ghku060c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Ni5z-_JEO4m8DxSeYtwMwA-1; Tue, 10 Mar 2026 12:09:54 -0400
X-MC-Unique: Ni5z-_JEO4m8DxSeYtwMwA-1
X-Mimecast-MFC-AGG-ID: Ni5z-_JEO4m8DxSeYtwMwA_1773158993
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3598518beceso9965569a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158991; cv=none;
        d=google.com; s=arc-20240605;
        b=T3lZCajc9XAAPj4JdMwseyuO5/yyJsRL2TcxlOSo23hyy+5LP35yLBioJPeLJnxkja
         Mdd43G2hR78zRdJrq6kEer5a+y5ZEGBRhZ6nJXjzJn71mbL7DcB7zqZZClN90m8SEhcy
         4m9mDujyom+ErFRjiceQOLO0vCVuo2CnRcIMl9mj84lQrVtst/oCRaK2cJ4rVyQF00t1
         RAb6rj3FXH426hUvqSHDkSCAeuW1M1ItAKz02npD2p2X62CjLm3jbfQbkQW+8nxmHqHO
         U4gHtOqRjC1jy739iorpEs59KVowANVL/3RPFDSoMK+HM9UUiUNj8REzu6NdPo1jCxiV
         f0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
        fh=i+Dddii+MpDmf9gPepBnZvcqv7yGTuQAgQ1F8N8JCeI=;
        b=aMOSQTnlspqei2gyFNDkk9egqvLnA/nM9hL0vNX/K93EnuF3ZfB/0wztmtokBilb8n
         OxXqQ8c+WSSVBQ7sUR7VA+PKc+cv/H7rAU1YBXeNJHDpTIgc0cZFcQ9Y5JgmmCyX6IwD
         km33Izf4YWAe2JXx6N1rbtkChfsfcrpW481JNjCftgwCr2kMqsUpIKrnbWpkAWQ3BeSP
         a+t6tbMdvDgf1oLmZ7qVYPf7N1fVJHXaarnfVXwMXS7Jxc6bN6A6+qbuFcLSJT6c1VQ/
         x8YedmbqWmwXqWUPssJwDBcRvTXcyC8gyQ6+SIV3I4BU3cjynQvpalUb+ylBpsd6b4Sh
         FBQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773158991; x=1773763791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
        b=Csr5eGz+0i2dwfNBKY9/Sy3guWmbFTrN4EvmaCXkswV8KbGZHvgkXPT+sEp7KbbY+e
         LbbAm2KizFaf5dbf/J0pclB5ONlNdd1HKE2+NJToQQMlysfW7TLXUf7S8x60Tlw+o0Yi
         jKqFPX67nCcm0jXnLhZZOErr/PD/Q/jQINzrDcZthcsLM6lkdoJoXU6tQMEeZ15NpN2L
         e/6TuU2N1GIMVkjkkCT8L8FJttSbAm6BO3ASJnZb7JNIN04yQzyD4P8qVCx81ZgrhgM/
         xdFwUvvyT1L1jEHIhfjm+k2A7aMhtaHdtNPsEnPoSnH0lgXzYC03WJd/7YL/IQBSUAsP
         LQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158991; x=1773763791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
        b=DU501T6Q9UA6cRmcPAEraffDptm19bXUnjmNNimQV4gC8ChmAiTJfxPA33zPLeNXdv
         u2ucMHFecuMm0dW5fwUEaLruAafrMle/7CTZ0sRxkT9/Wd29P5Ndi8QR/Gsn7icSCXJt
         calGBvM604v1Jtn/DVEpC5Yg/9bmZ6pjNXSTVI3kdJMM6CwfzkNvyKlgcbrqSqzEhZiE
         HfmG8XcqtvNgyigYoVGh7KJFcp/0kObNFivglvGMJVIORW/HOOaqN8sVe/otKR7FbhDU
         mmlLODM/L2J7fb1LLCxqSaOQzQtQTgwz1plM4Lhohb5KmMrHmVZnIyCkZbF5Mm9mNgGb
         2V0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAY2KBtFec5q6zO8G9s8g8ozCzbrsrgGnqY7rxg4u0BNiyvvh1qIlNIr+Hi6lZXfd07gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysERk/BcJhY5E7u9pnHQbqFxuUr8IOinLyG4C1zbg/AdvhOP8
	K8uPCAMoKXycJ/9dgDocexJe2IhFBzd66LaAhe0WMt6oP9II2cUHIQtWTALNEdvVUb+ytM7BWXO
	+Yvlwceh6qBIinT+TFrFjUu+q0b7vcRukgEsbD2nTPOVhtiqzY96DCFes/JtNBgkdb1jd2F9Uho
	OWBDSXSBTvrk0INGSwNzcOVW479teG
X-Gm-Gg: ATEYQzzLNLBttdedEV2vrylGFfsL2sTGhqIpEsfoFhSuNDn1r/D3z1jozI6lG8w2ypI
	IW2MOyFKI10jM7TcKApxUhhJQs8DZ4ctgUG+R8an2a6KfCU09ifR43impOWrEOXtu6ShZNX3kQK
	CmW9jExcoUNWS9bqMp5QxSxdFW9l6KvcNhImQiIb4S7ADyjxusqmA814TDHf80IqTn3Jb4rTkrA
	uvjRkFKvmwM41LS2ysQtEfiWqGrgPDTRTiIy/AOjt90bIY6TTLG5jSVnpIzi4TDeolad5u6DJCj
	kMZVoDL5l0XA4TBOgVUuA0Q=
X-Received: by 2002:a17:90b:4c0b:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-359be21cbe3mr13385908a91.4.1773158990764;
        Tue, 10 Mar 2026 09:09:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0b:b0:340:bfcd:6af8 with SMTP id
 98e67ed59e1d1-359be21cbe3mr13385885a91.4.1773158990317; Tue, 10 Mar 2026
 09:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com> <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
In-Reply-To: <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Mar 2026 17:09:38 +0100
X-Gm-Features: AaiRm53D_fI1H70-F1ikhogxji9xkIEVV_aZIVYBCcLuGeymmaChwnXNt6tcmrY
Message-ID: <CAMxuvaycCnFjhqtv5Gvi93W-ndEDqFbdgTn-pmYbyMAOW-v7CQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>, 
	David Hildenbrand <david@kernel.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Mar 10, 2026 at 6:35=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This is an attempt to fix the incompatibility of virtio-mem with confid=
ential
> > VMs. The solution implements what was discussed earlier with D. Hildenb=
rand:
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18=
657-5-chenyi.qiang@intel.com/#3502238
> >
> > The first patches are misc cleanups. Then some code refactoring to have=
 split a
> > manager/source. And finally, the manager learns to deal with multiple s=
ources.
> >
> > I haven't done thorough testing. I only launched a SEV guest with a vir=
tio-mem
> > device. It would be nice to have more tests for those scenarios with
> > VFIO/virtio-mem/confvm.. In any case, review & testing needed!
>
> Is this series aimed to enable virtio-mem (memory hotplug) in a confident=
ial VM?
> I tested it within a TD guest using the qemu command:
>
> qemu-system-x86_64
>         ...
>         -m 2G,maxmem=3D10G \
>         -smp sockets=3D1,cores=3D2 \
>         -object memory-backend-ram,id=3Dmem0,size=3D2G \
>         -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dmem0 \
>         -object memory-backend-ram,id=3Dvmem0,size=3D8G \
>         -device virtio-mem-pci,id=3Dvm0,memdev=3Dvmem0,node=3D0,requested=
-size=3D300M \
>         -object tdx-guest,id=3Dtdx \
>         -machine q35,kernel_irqchip=3Dsplit,hpet=3Doff,memory-encryption=
=3Dtdx \
>         ...
>
> The TD VM will exit with the error when the guest kernel loads the virtio=
-mem driver:
>
>     kvm_intel: Guest access before accepting 0x108008000 on vCPU 0
>
> I think it still lacks some support to accept the TD guest memory before =
using it.
>

It becomes increasingly hard to provide easy to setup reproducibe
environments.. but here is the libvirt qemu command I just tested
succesfully against:

qemu-system-x86_64 -name guest=3Drhel10,debug-threads=3Don -S -object
{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/home/elmarco=
/.config/libvirt/qemu/lib/domain-3-rhel10/master-key.aes"}
-machine pc-q35-10.1,usb=3Doff,smm=3Doff,dump-guest-core=3Doff,confidential=
-guest-support=3Dlsec0,hpet=3Doff,acpi=3Don
-accel kvm -cpu host,migratable=3Don -bios
/usr/share/edk2/ovmf/OVMF.inteltdx.fd -m
size=3D4096000k,slots=3D1,maxmem=3D8192000k -overcommit mem-lock=3Doff -smp
2,sockets=3D2,cores=3D1,threads=3D1 -object
{"qom-type":"memory-backend-ram","id":"ram-node0","size":4194304000}
-numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dram-node0 -uuid
0f3e6b74-80e3-45e7-a0e6-ae7dfc897606 -display none -no-user-config
-nodefaults -chardev socket,id=3Dcharmonitor,fd=3D23,server=3Don,wait=3Doff
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay
-no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
{"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","bus":"pcie.0"=
,"multifunction":true,"addr":"0x1"}
-device {"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","bus":=
"pcie.0","addr":"0x1.0x1"}
-device {"driver":"pcie-root-port","port":10,"chassis":3,"id":"pci.3","bus"=
:"pcie.0","addr":"0x1.0x2"}
-device {"driver":"pcie-root-port","port":11,"chassis":4,"id":"pci.4","bus"=
:"pcie.0","addr":"0x1.0x3"}
-device {"driver":"pcie-root-port","port":12,"chassis":5,"id":"pci.5","bus"=
:"pcie.0","addr":"0x1.0x4"}
-device {"driver":"pcie-root-port","port":13,"chassis":6,"id":"pci.6","bus"=
:"pcie.0","addr":"0x1.0x5"}
-device {"driver":"pcie-root-port","port":14,"chassis":7,"id":"pci.7","bus"=
:"pcie.0","addr":"0x1.0x6"}
-device {"driver":"pcie-root-port","port":15,"chassis":8,"id":"pci.8","bus"=
:"pcie.0","addr":"0x1.0x7"}
-device {"driver":"pcie-root-port","port":16,"chassis":9,"id":"pci.9","bus"=
:"pcie.0","multifunction":true,"addr":"0x2"}
-device {"driver":"pcie-root-port","port":17,"chassis":10,"id":"pci.10","bu=
s":"pcie.0","addr":"0x2.0x1"}
-device {"driver":"pcie-root-port","port":18,"chassis":11,"id":"pci.11","bu=
s":"pcie.0","addr":"0x2.0x2"}
-device {"driver":"pcie-root-port","port":19,"chassis":12,"id":"pci.12","bu=
s":"pcie.0","addr":"0x2.0x3"}
-device {"driver":"pcie-root-port","port":20,"chassis":13,"id":"pci.13","bu=
s":"pcie.0","addr":"0x2.0x4"}
-device {"driver":"pcie-root-port","port":21,"chassis":14,"id":"pci.14","bu=
s":"pcie.0","addr":"0x2.0x5"}
-device {"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.2","add=
r":"0x0"}
-device {"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.3","=
addr":"0x0"}
-object {"qom-type":"memory-backend-ram","id":"memvirtiomem0","reserve":fal=
se,"size":4194304000}
-device {"driver":"virtio-mem-pci","node":0,"block-size":2097152,"memdev":"=
memvirtiomem0","id":"virtiomem0","bus":"pci.7","addr":"0x0"}
-blockdev {"driver":"file","filename":"/home/elmarco/rhel-10.qcow2","node-n=
ame":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
-blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2=
","file":"libvirt-1-storage","backing":null}
-device {"driver":"virtio-blk-pci","bus":"pci.4","addr":"0x0","drive":"libv=
irt-1-format","id":"virtio-disk0","bootindex":1}
-netdev {"type":"user","id":"hostnet0"} -device
{"driver":"virtio-net-pci","netdev":"hostnet0","id":"net0","mac":"52:54:00:=
82:08:40","bus":"pci.1","addr":"0x0"}
-chardev pty,id=3Dcharserial0 -device
{"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0}
-chardev socket,id=3Dcharchannel0,fd=3D22,server=3Don,wait=3Doff -device
{"driver":"virtserialport","bus":"virtio-serial0.0","nr":1,"chardev":"charc=
hannel0","id":"channel0","name":"org.qemu.guest_agent.0"}
-chardev socket,id=3Dchrtpm,path=3D/run/user/1006/libvirt/qemu/run/swtpm/3-=
rhel10-swtpm.sock
-tpmdev emulator,id=3Dtpm-tpm0,chardev=3Dchrtpm -device
{"driver":"tpm-crb","tpmdev":"tpm-tpm0","id":"tpm0"} -audiodev
{"id":"audio1","driver":"none"} -global ICH9-LPC.noreboot=3Doff
-watchdog-action reset -device
{"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.5","addr":"0x0"}
-object {"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}
-device {"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.6=
","addr":"0x0"}
-object {"qom-type":"tdx-guest","id":"lsec0","quote-generation-socket":{"ty=
pe":"unix","path":"/var/run/tdx-qgs/qgs.socket"},"attributes":268435456}
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny
-msg timestamp=3Don

Then I hotplugged some mem:
virsh --connect qemu:///session update-memory-device rhel10
--requested-size 2GiB

[  166.228943] virtio_mem virtio5: plugged size: 0x0
[  166.231784] virtio_mem virtio5: requested size: 0x80000000


[root@rhel10-server ~]# lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff   2G online       yes  0-15
0x0000000100000000-0x00000001ffffffff   4G online       yes 32-63

Memory block size:       128M
Total online memory:       6G
Total offline memory:      0B

The host kernel used is experimental; it's a patched version of
6.19.0-rc8 that I don't have the details)

> >
> > (should fix https://issues.redhat.com/browse/RHEL-131968)
> >
> > v3: issues found by C=C3=A9dric
> >  - fix assertion error on shutdown, due to rcu-defer cleanup
> >  - fix API doc warnings
> >
> > v2:
> >  - drop replay_{populated,discarded} from source, suggested by Peter Xu
> >  - add extra manager cleanup
> >  - add r-b tags for preliminary patches
> >
> > thanks
> >
> > Marc-Andr=C3=A9 Lureau (15):
> >   system/rba: use DIV_ROUND_UP
> >   memory: drop RamDiscardListener::double_discard_supported
> >   virtio-mem: use warn_report_err_once()
> >   system/memory: minor doc fix
> >   kvm: replace RamDicardManager by the RamBlockAttribute
> >   system/memory: split RamDiscardManager into source and manager
> >   system/memory: move RamDiscardManager to separate compilation unit
> >   system/memory: constify section arguments
> >   system/ram-discard-manager: implement replay via is_populated
> >     iteration
> >   virtio-mem: remove replay_populated/replay_discarded implementation
> >   system/ram-discard-manager: drop replay from source interface
> >   system/memory: implement RamDiscardManager multi-source aggregation
> >   system/physmem: destroy ram block attributes before RCU-deferred
> >     reclaim
> >   system/memory: add RamDiscardManager reference counting and cleanup
> >   tests: add unit tests for RamDiscardManager multi-source aggregation
> >
> >  include/hw/vfio/vfio-container.h            |    2 +-
> >  include/hw/vfio/vfio-cpr.h                  |    2 +-
> >  include/hw/virtio/virtio-mem.h              |    3 -
> >  include/system/memory.h                     |  287 +----
> >  include/system/ram-discard-manager.h        |  358 ++++++
> >  include/system/ramblock.h                   |    3 +-
> >  accel/kvm/kvm-all.c                         |    2 +-
> >  hw/vfio/cpr-legacy.c                        |    4 +-
> >  hw/vfio/listener.c                          |   12 +-
> >  hw/virtio/virtio-mem.c                      |  290 +----
> >  migration/ram.c                             |    6 +-
> >  system/memory.c                             |   83 +-
> >  system/memory_mapping.c                     |    4 +-
> >  system/physmem.c                            |    2 +-
> >  system/ram-block-attributes.c               |  279 +----
> >  system/ram-discard-manager.c                |  612 +++++++++
> >  tests/unit/test-ram-discard-manager-stubs.c |   48 +
> >  tests/unit/test-ram-discard-manager.c       | 1234 +++++++++++++++++++
> >  system/meson.build                          |    1 +
> >  tests/unit/meson.build                      |    8 +-
> >  20 files changed, 2361 insertions(+), 879 deletions(-)
> >  create mode 100644 include/system/ram-discard-manager.h
> >  create mode 100644 system/ram-discard-manager.c
> >  create mode 100644 tests/unit/test-ram-discard-manager-stubs.c
> >  create mode 100644 tests/unit/test-ram-discard-manager.c
> >
>

