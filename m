Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CA3148CF
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238339; cv=pass; b=Zlxnh+P6VW2gNi2B0Vhvyxh2IoJGFL4UfMamAAK2KGT0ZZsln5ftXvSbZ986Z7nB430T8qPogBYSD5Z/ts/5aIfRGLa+b22MOfSwrgzpPhmtSZKjbKxSvfHK65mmpcCMexdyboisPMoidr9hEucmubhUvk6oGd9Usd6jM204l6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238339; c=relaxed/simple;
	bh=goQXVwMC1AKBq0MkwIm24bpPv+CfQx9l6naNEV5DaZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axvk2gL4QckgdYeLPM7gv9fWIU3mAnFiEgD0aVjvG9rhbFc76DCZXpTY1fdgORrZ8CLE/pcx46Guwdld28ei6HMiwvqHCERgbGANMfVvQa+UQkSR5bWNqhpAEs+v2Dm0ZpVPD5n1kmQ5A3adxYj8XP6G5xQFexsPki6Y11eCXL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vkb6DuWn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahOK6+4U; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vkb6DuWn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahOK6+4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773238336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lArRU5vkfVvi2dtuNv2JQyGJ7FIgBCpSZrUmUnp3r28=;
	b=Vkb6DuWnmZp1RG2RppxPerk9hfR/+YACdzA18K4/GuxG1U59yz2DfM0b43SRD70J4aWosK
	y6K3XW26EGxRnRNeLhdFPD7JRyFXQOxjT6b1V09MvjMQH2MMxfbS9zQIla4gCMLE/ic8CK
	R6NBH0bAwlsS6UFKfdW2R6+qvue5g6o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-4uVL-GrkOBGms8RvBwG5VA-1; Wed, 11 Mar 2026 10:12:15 -0400
X-MC-Unique: 4uVL-GrkOBGms8RvBwG5VA-1
X-Mimecast-MFC-AGG-ID: 4uVL-GrkOBGms8RvBwG5VA_1773238334
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-359f31809a0so9267313a91.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773238333; cv=none;
        d=google.com; s=arc-20240605;
        b=UfpnAey2c29vAVSYXYZPkFVxQErteyE7++V+RcXdjmJ1yHY1VXRiFxH9KG4PHyb1BJ
         22y+5I7KBSELJDqcC4QmqqdvU3uAuMxxjBaXzjHIE47ix/f2KcSh65INscFK8GVNdxQv
         S1mS3ERSbpXH09hpl+GUDpk7KhMStfBlIt20mNyHYoJmlJvmtq0uwYykA2AvVVtlScei
         T7rCc9WbQI0E+ku9aUp1C0ThmJoF0f4WOae+dPPF4eKRfsUh4/N/VhXcg71LXN624+kF
         nkW4E0CC6SAkBHay1xxtFHw7HW0b4uwpgZCEw99FPt7wzjM34U93DTOTA82BGvFcBjZg
         Csxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lArRU5vkfVvi2dtuNv2JQyGJ7FIgBCpSZrUmUnp3r28=;
        fh=Nfr33bl5masVGHXo6FeLG5rBBYnk3ZLl+qvFNwKEorw=;
        b=f4ZLV6Z2fwzid1UgnHCA1y0WQlwfirdtQIE8AaJosk/UViIOaNLCgVyGoXvOMMIx0z
         TiQV4/X4xYw0C4rBCSExC9+NpPHAsk4qc/vJ39Jjwtq0PREQCy0FqilNNJJqrUDzP0oL
         YDtFXw8bRv6ISWIPW4VcFPwXAYCn+D/MNkht7d9Yn3+qzcCa9HkR5xzrHCpFVUzM9Cav
         h580Zh8EVxIO83pqHraBvzHOSkrtK3EVxuYyvamZ6ZXhpVrquqLJ0zbLW/pBV7wA54hS
         cM2RvOUypAyEPVJj0i5D6fd5cPrxLZORKTYwgiGMCV3onHhGDN2aRNaz2ojjd0gbFJig
         hYqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773238333; x=1773843133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lArRU5vkfVvi2dtuNv2JQyGJ7FIgBCpSZrUmUnp3r28=;
        b=ahOK6+4UOlvWlPRXrY1bCTvVTDCUWjwQQ3ip94G5wWHkoJP4ChmaRkEO1HR1Au6TNK
         eG73cVbfI+UUC9p52C1iaTq82RJTM9HScW0yJAsHkpujTD0rhT1VdlQKeZaICC5Nm5eU
         KHeGyK34h956p/Mvh48OUIxHHsjrXdv9hzyrhPeGkir+GdpILglvjJbLYfqioklGICms
         RF/WjexDmep+Y7zj/3GheII6qZMEYeEMX88zhblrtC5QG4jLspyImfxaGpWvpymCZE4B
         IzYLn5xTElnzVfqDycKKVsO2hEsmxTolpHqymLdVOCWiDxfLV6cmOkurRikKJoVTYwTK
         tj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238333; x=1773843133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lArRU5vkfVvi2dtuNv2JQyGJ7FIgBCpSZrUmUnp3r28=;
        b=czf/PI+0UPvDUkVsyKXWvgpV5aD8/OXjAeAZg6+S5ZV7QaDvZMi8i1rh1HIQE5CG9H
         5gM/TzfPdnwmfKO4pkUYOLmBTL+1ylJRxxE/UZl2vlefkbGcOb/U+54nVXw/AP/nNHmH
         +OiI0wNJX1MaMu3H/MZtGowxp+Dya2DKuxgO/NHD+pF8jjwfWqijrhyInauwqGtyPfgH
         thciCLcGSPlZJV4SilNtME5UwdpzStZY4cuQMGLECL61kIbAN6iJAFpZphb7RjIFMmvq
         yd3mNr0fLErqT9HWscbnvh1HjBqmqrF2JzypTrERCmGuV/QMpfQG3mrOHj0zD/VJDzVx
         da/A==
X-Forwarded-Encrypted: i=1; AJvYcCUqeagJqZSopwk+pfM2G/yuwt5J7O1G5/yERUVGF8oUhhqDs1qvq++P4HfSSyCVVx8vcsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HY8woh+zDvLNBqivWqO/9FMwGl6Pz9/WGatVQZw/Izvl2OX2
	z0WWJ2Jat1JaG7eanD6pcjMzTzTZISlL470LaQrKTurbH8BaEckquOuAxbpQh3MHXNPm6XEJQJG
	lzV1fqCopXCtrodLm6LYh1dPZubAcqmyyuOo7edJIdjKS+IXOkOugJcj8ALFlKWM7wQALKD2OaF
	l525Mi8YCZsU92DuWwagMMz9YIYx8L
X-Gm-Gg: ATEYQzzETDnGWOGi4KU07bMKYBomvdrN83sc0mMoghW76YCrD0ABnoEL1aD4vkjAZvu
	8OGTICQeK4YkvOAHrAglBPIRXKSn1okiFLlPCxORKTbkjZYe+nKyuv1GrUi4JPwWU8VscBJSNKi
	vqwg3+ajwsyJLWb7HnHXO6aLVBxnP7lsATdxzk/S36Aa/YZIAyl+2X1yxuRoewUX7El2WA98/rO
	xKMnDEmoCPQuaE8M3s0n0v78g38/LMMMQCWttlDfa+77nzaleOl4+SxZ5wZdUewfH7Yum50Hapw
	iKR8yrW/og1z2ZJNGzDhfsk=
X-Received: by 2002:a17:90b:2fcd:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-35a0138a160mr2545395a91.17.1773238333457;
        Wed, 11 Mar 2026 07:12:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2fcd:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-35a0138a160mr2545368a91.17.1773238332854; Wed, 11 Mar 2026
 07:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com> <CAMxuvaycCnFjhqtv5Gvi93W-ndEDqFbdgTn-pmYbyMAOW-v7CQ@mail.gmail.com>
 <cf341392-bb32-4497-997e-a46902da56c5@intel.com>
In-Reply-To: <cf341392-bb32-4497-997e-a46902da56c5@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Mar 2026 15:12:01 +0100
X-Gm-Features: AaiRm53kM9_vaEJv2WSq8CtA66fLxOtQnhEoxuIwGe0anqdSa9tNeT7nqDQBKIU
Message-ID: <CAMxuvaw8W_PrG2Q+-G3zFfuBHwp6ReKQbkTEE5Ma7v4c=Stm2A@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Mar 11, 2026 at 11:18=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.c=
om> wrote:
>
>
>
> On 3/11/2026 12:09 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Mar 10, 2026 at 6:35=E2=80=AFAM Chenyi Qiang <chenyi.qiang@inte=
l.com> wrote:
> >>
> >>
> >>
> >> On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Hi,
> >>>
> >>> This is an attempt to fix the incompatibility of virtio-mem with conf=
idential
> >>> VMs. The solution implements what was discussed earlier with D. Hilde=
nbrand:
> >>> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.=
18657-5-chenyi.qiang@intel.com/#3502238
> >>>
> >>> The first patches are misc cleanups. Then some code refactoring to ha=
ve split a
> >>> manager/source. And finally, the manager learns to deal with multiple=
 sources.
> >>>
> >>> I haven't done thorough testing. I only launched a SEV guest with a v=
irtio-mem
> >>> device. It would be nice to have more tests for those scenarios with
> >>> VFIO/virtio-mem/confvm.. In any case, review & testing needed!
> >>
> >> Is this series aimed to enable virtio-mem (memory hotplug) in a confid=
ential VM?
> >> I tested it within a TD guest using the qemu command:
> >>
> >> qemu-system-x86_64
> >>         ...
> >>         -m 2G,maxmem=3D10G \
> >>         -smp sockets=3D1,cores=3D2 \
> >>         -object memory-backend-ram,id=3Dmem0,size=3D2G \
> >>         -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dmem0 \
> >>         -object memory-backend-ram,id=3Dvmem0,size=3D8G \
> >>         -device virtio-mem-pci,id=3Dvm0,memdev=3Dvmem0,node=3D0,reques=
ted-size=3D300M \
> >>         -object tdx-guest,id=3Dtdx \
> >>         -machine q35,kernel_irqchip=3Dsplit,hpet=3Doff,memory-encrypti=
on=3Dtdx \
> >>         ...
> >>
> >> The TD VM will exit with the error when the guest kernel loads the vir=
tio-mem driver:
> >>
> >>     kvm_intel: Guest access before accepting 0x108008000 on vCPU 0
> >>
> >> I think it still lacks some support to accept the TD guest memory befo=
re using it.
> >>
> >
> > It becomes increasingly hard to provide easy to setup reproducibe
> > environments.. but here is the libvirt qemu command I just tested
> > succesfully against:
> >
> > qemu-system-x86_64 -name guest=3Drhel10,debug-threads=3Don -S -object
> > {"qom-type":"secret","id":"masterKey0","format":"raw","file":"/home/elm=
arco/.config/libvirt/qemu/lib/domain-3-rhel10/master-key.aes"}
> > -machine pc-q35-10.1,usb=3Doff,smm=3Doff,dump-guest-core=3Doff,confiden=
tial-guest-support=3Dlsec0,hpet=3Doff,acpi=3Don
> > -accel kvm -cpu host,migratable=3Don -bios
> > /usr/share/edk2/ovmf/OVMF.inteltdx.fd -m
> > size=3D4096000k,slots=3D1,maxmem=3D8192000k -overcommit mem-lock=3Doff =
-smp
> > 2,sockets=3D2,cores=3D1,threads=3D1 -object
> > {"qom-type":"memory-backend-ram","id":"ram-node0","size":4194304000}
> > -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dram-node0 -uuid
> > 0f3e6b74-80e3-45e7-a0e6-ae7dfc897606 -display none -no-user-config
> > -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D23,server=3Don,wait=
=3Doff
> > -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
> > base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay
> > -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
> > ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
> > {"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","bus":"pci=
e.0","multifunction":true,"addr":"0x1"}
> > -device {"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","b=
us":"pcie.0","addr":"0x1.0x1"}
> > -device {"driver":"pcie-root-port","port":10,"chassis":3,"id":"pci.3","=
bus":"pcie.0","addr":"0x1.0x2"}
> > -device {"driver":"pcie-root-port","port":11,"chassis":4,"id":"pci.4","=
bus":"pcie.0","addr":"0x1.0x3"}
> > -device {"driver":"pcie-root-port","port":12,"chassis":5,"id":"pci.5","=
bus":"pcie.0","addr":"0x1.0x4"}
> > -device {"driver":"pcie-root-port","port":13,"chassis":6,"id":"pci.6","=
bus":"pcie.0","addr":"0x1.0x5"}
> > -device {"driver":"pcie-root-port","port":14,"chassis":7,"id":"pci.7","=
bus":"pcie.0","addr":"0x1.0x6"}
> > -device {"driver":"pcie-root-port","port":15,"chassis":8,"id":"pci.8","=
bus":"pcie.0","addr":"0x1.0x7"}
> > -device {"driver":"pcie-root-port","port":16,"chassis":9,"id":"pci.9","=
bus":"pcie.0","multifunction":true,"addr":"0x2"}
> > -device {"driver":"pcie-root-port","port":17,"chassis":10,"id":"pci.10"=
,"bus":"pcie.0","addr":"0x2.0x1"}
> > -device {"driver":"pcie-root-port","port":18,"chassis":11,"id":"pci.11"=
,"bus":"pcie.0","addr":"0x2.0x2"}
> > -device {"driver":"pcie-root-port","port":19,"chassis":12,"id":"pci.12"=
,"bus":"pcie.0","addr":"0x2.0x3"}
> > -device {"driver":"pcie-root-port","port":20,"chassis":13,"id":"pci.13"=
,"bus":"pcie.0","addr":"0x2.0x4"}
> > -device {"driver":"pcie-root-port","port":21,"chassis":14,"id":"pci.14"=
,"bus":"pcie.0","addr":"0x2.0x5"}
> > -device {"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.2",=
"addr":"0x0"}
> > -device {"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.=
3","addr":"0x0"}
> > -object {"qom-type":"memory-backend-ram","id":"memvirtiomem0","reserve"=
:false,"size":4194304000}
> > -device {"driver":"virtio-mem-pci","node":0,"block-size":2097152,"memde=
v":"memvirtiomem0","id":"virtiomem0","bus":"pci.7","addr":"0x0"}
> > -blockdev {"driver":"file","filename":"/home/elmarco/rhel-10.qcow2","no=
de-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
> > -blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"q=
cow2","file":"libvirt-1-storage","backing":null}
> > -device {"driver":"virtio-blk-pci","bus":"pci.4","addr":"0x0","drive":"=
libvirt-1-format","id":"virtio-disk0","bootindex":1}
> > -netdev {"type":"user","id":"hostnet0"} -device
> > {"driver":"virtio-net-pci","netdev":"hostnet0","id":"net0","mac":"52:54=
:00:82:08:40","bus":"pci.1","addr":"0x0"}
> > -chardev pty,id=3Dcharserial0 -device
> > {"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0=
}
> > -chardev socket,id=3Dcharchannel0,fd=3D22,server=3Don,wait=3Doff -devic=
e
> > {"driver":"virtserialport","bus":"virtio-serial0.0","nr":1,"chardev":"c=
harchannel0","id":"channel0","name":"org.qemu.guest_agent.0"}
> > -chardev socket,id=3Dchrtpm,path=3D/run/user/1006/libvirt/qemu/run/swtp=
m/3-rhel10-swtpm.sock
> > -tpmdev emulator,id=3Dtpm-tpm0,chardev=3Dchrtpm -device
> > {"driver":"tpm-crb","tpmdev":"tpm-tpm0","id":"tpm0"} -audiodev
> > {"id":"audio1","driver":"none"} -global ICH9-LPC.noreboot=3Doff
> > -watchdog-action reset -device
> > {"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.5","addr":"0x=
0"}
> > -object {"qom-type":"rng-random","id":"objrng0","filename":"/dev/urando=
m"}
> > -device {"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"p=
ci.6","addr":"0x0"}
> > -object {"qom-type":"tdx-guest","id":"lsec0","quote-generation-socket":=
{"type":"unix","path":"/var/run/tdx-qgs/qgs.socket"},"attributes":268435456=
}
> > -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resou=
rcecontrol=3Ddeny
> > -msg timestamp=3Don
> >
> > Then I hotplugged some mem:
> > virsh --connect qemu:///session update-memory-device rhel10
> > --requested-size 2GiB
> >
> > [  166.228943] virtio_mem virtio5: plugged size: 0x0
> > [  166.231784] virtio_mem virtio5: requested size: 0x80000000
> >
> >
> > [root@rhel10-server ~]# lsmem
> > RANGE                                 SIZE  STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff   2G online       yes  0-15
> > 0x0000000100000000-0x00000001ffffffff   4G online       yes 32-63
> >
> > Memory block size:       128M
> > Total online memory:       6G
> > Total offline memory:      0B
> >
> > The host kernel used is experimental; it's a patched version of
> > 6.19.0-rc8 that I don't have the details)
>
> It seems related to the memory size. Maybe you can have a try with "-m 2G=
,maxmem=3D4G".
> I hit the problem when the size <=3D 2G and no range above 4g at the begi=
nning.

Right, it crashes when I use -m 2G:

error: kvm run failed Input/output error
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000c06f2
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00>
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00
kvm_mem_ioeventfd_del: error deleting ioeventfd: Input/output error (5)

This is a bit outside of my comfort zone,
maybe Paolo can provide some hints?

