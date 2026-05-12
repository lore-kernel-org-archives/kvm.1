Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331C3B2D3B
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596339; cv=pass; b=F414ScXjlmDbfah3xdglyquIeHuDEt+s71t5BSaKSV1YzsOnQuBCI4T2zmmOUsSB7CjYkY5V2nWYoRh1a/m1uEPWHuFaWCMAVCLahSSxJBA8wGIX/cUKmgo3/UKXJX9/JMHh0odLs9wH3/Fl/f5tftDMiQoe0RMZmq3iKT+Vl6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596339; c=relaxed/simple;
	bh=N7lyBlpl85AAjN6/EX7SzGCE/n/hJ5nGHn+rLcZrTvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJEKMjkKyAG9uqqn4Ce9SD8tuxwSiWfJQlCkgagmfRuUSjnBbb4kn1DpUeyVWmSN2T+Kme2swbN/TzeDxn2mpRrEs4pjpQ36KvEWsI7iuamSFSCSEi/FnGVxitLSta6vksXPtJyjQQkciZ47eu/3p3XHrlsGmyGt8+vhf4CLDAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dc0qVWqq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICTNK1La; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc0qVWqq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICTNK1La"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778596337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lxYxFSAW/yzzFCNEXy8FbGIa5a48S9ikClCWc225fA=;
	b=Dc0qVWqqUiidv7p+hqsTNQMadyxTyUvoXRnTpelqs4YVuroVuWTv0yvMArFInvyExU9dQ6
	w4d5lD5Lx10coGqRxxtaGOl6/w4I9vCadDWEt5KFvCc6t6ZXT7Masvr7Sci7VAQLExyINm
	Ac2uNW/PFq6Ak38zOWegsd+NyYGnQcc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Gi1l6_E9MHSLHqLrzNChkw-1; Tue, 12 May 2026 10:32:15 -0400
X-MC-Unique: Gi1l6_E9MHSLHqLrzNChkw-1
X-Mimecast-MFC-AGG-ID: Gi1l6_E9MHSLHqLrzNChkw_1778596334
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso33754265e9.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 07:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596333; cv=none;
        d=google.com; s=arc-20240605;
        b=HSgZWiO4qXnULHGKxEBRbC3dl0tK6on78hDOykP04V1nT4w2MZ7Se+bjU14suJ2ghf
         TMJkQMEhtnebUvl3kpKy6A16aMc7q3IAthOc/ctMcj/ph8dLI07XRCPQFcfKsWB2ooTb
         qGqKGidsrYIN2tDfNWYw39wna1RQBZuJQz5OC98H6IlJdUNf0Mql/U848vu6MkWAc/FE
         jiAZ5QjGZl8BIqiWdcpcPx2X0+zcUEuRcs79kQ5laooJHa8oCd+UcMm2TdXMkpbRxk55
         7Xm7Ec0HFZmOrjO58vkScBO9NlMP/ZZSH/et00mJ7NcMKEmYRUk/i6NYDN6XfUd8y8FK
         Hmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lxYxFSAW/yzzFCNEXy8FbGIa5a48S9ikClCWc225fA=;
        fh=LUQ+e4sVJIVTItbLsOYC4g+iZQUEd5NKyVzoxQAMndE=;
        b=Z2YswH+Y2oVwa1P4cXpOVMAr78uTP1sWbxHNXsVUIC/X2sMFbvD/QnwMkYKVnhKehM
         wai9VXQrGg0HMx0HffnTOcvM4BfAT2CuBZtzGYrC1NWf2ClkSGBC2hI4T1qi2pq48J9C
         O4OK9/w7lp3nTqck5oH52X5lIGZ9ajgs1EOAQjBgCtnnZXNlnCYcTPR34p21uXyLkcu4
         3Hb9m9Euv6aCFi5oZiclQM12rrY2POHmGewyisbVugNc/63op7CHPz5kaTMXx0HLAPri
         I7BfDw9N2r7LPl8DiSTLXbq3ufSiwaQAguEJQKFLv9DKFMovSscIGnDnhIPnZIN1gPpO
         G1jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778596333; x=1779201133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lxYxFSAW/yzzFCNEXy8FbGIa5a48S9ikClCWc225fA=;
        b=ICTNK1LaPXfymCbf2rsObhXGQcM09gVsZtJPpOkQdSSgAbCE3YMmXL+0131UEOuqGL
         PIyG3HArwgAbdNVZSZAkgeqVJwJgLqMuOnD2smexPlIT3uoiXrcAZCD096PrMiyyjxZY
         s5OwE0ojG2OzdLj7MWBfpjQFHoIf0uEJ45g+e3Xfhl4JIwAF3BWvlroQs76EN0a2XlXN
         tutwhV5oVtgODI2Z5YAWkLVgcBBUXyCsTUZLvvbvs6Yx1ctkJkAQlzeUgCS/iAZH3AyJ
         YmcncUTeBH4i8Qu9kx0M6WIgfNxskSdqBIUG54FVVg20DjHXZOBaxa63XAeRUCIipGDs
         sXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596333; x=1779201133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lxYxFSAW/yzzFCNEXy8FbGIa5a48S9ikClCWc225fA=;
        b=EKR+1I6YVNbZ7632c5OGoyW9EF6TFVv0UKhDovaq4JFD/ZK3B/FHFyDrXsacCcTTjU
         nxYwakYcVHYD6qEZGnZRMQsPsOWKXVQ4Bop00Dgs1Om25LS98Cv+7nXdxZJMK+w0YfPI
         BWYPJPByOSa1Cwcn4e96QfvcBw5CD0NLRB0w+Si8Ki8C748JdK4KuEUs/rqfWuwPsZve
         HQG9/jzZMplyOClXeZuMi1Sak1gj9nxFl/bFN2y3ev+XG+ezmaxGMjYpQKaUADtiDRQA
         GPUMrVNrf4oWjy0rYXb8zX+DTJ0gHyl1z/ufKAPyefS6jqpFLoaCRDEG3TrvO8Gg60TL
         9bkA==
X-Forwarded-Encrypted: i=1; AFNElJ+shIyM6s2gV2KAzSClvRNsuiVNYafhGTFTYbwUiHNQa31u4vFQitOuHFxcxroYFCbmHmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwHa0gk+UBca+3KMybVmZH7STXk5zGC4wp/48GZXrZOBoWTZu
	sAqZ0RpJYL1BDGVJNVMw+GrUUKcSdle9ncqlouqS6OBchkhz/Mll8Q9Za6vTCvhkKkyVpn1b070
	KNe+kNHVIRUfX2LVYSIb00P97q2zikd7JNnviwOea4JkIfUMa8eQhR0xzaD1F5eUMaodgqGk74Z
	HJe/NR8sn5f5heZ5JrA15/tgELYnVquqfdU1O1Rug=
X-Gm-Gg: Acq92OG64sejU2bFV3mFh11QDGejrKYtZ1o7uVngUn00dd1DAMzmqOEZZ7llYNqpJ84
	XFttAyL2xLiKQGMcpfV1vgYjWJB7wOR/CMwqY9Yn266ikQ0U2CDsuagfBze72P8oa2pc/M19UJW
	Ywneq26H52AOXf7I46Q4G4yzkLYem03qD9ZjO1Bj/gzA8T63okDt8hIqx+50jZafmzX4yYl+X6R
	xGcbfVyjAs6rxzqM5V4f8HuXMj2k5umDGE6R2IEWXtgafw3MO26aB04Wnpe2eXRtkG0RspIKKqH
	L+E/tET7
X-Received: by 2002:a05:600c:34c9:b0:48e:75fd:9f9e with SMTP id 5b1f17b1804b1-48e8fe7ca80mr55597685e9.20.1778596332948;
        Tue, 12 May 2026 07:32:12 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:48e:75fd:9f9e with SMTP id
 5b1f17b1804b1-48e8fe7ca80mr55597105e9.20.1778596332488; Tue, 12 May 2026
 07:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
In-Reply-To: <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 May 2026 16:32:00 +0200
X-Gm-Features: AVHnY4KYitMBZNYzckOhbaQ1qaVIropGZmgsfct4kgzigRtJ4gr_Sggvx8bWQwk
Message-ID: <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: David Riley <d.riley@proxmox.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 12:54=E2=80=AFPM David Riley <d.riley@proxmox.com> =
wrote:
> Environment:
> - Kernel: mainline 7.1.0-rc2 (with v6 patches applied)

Using 7.0.4 + v6 patches applied (except for the AMD ones) I could
reproduce the guest not booting, but not the host lockups. I also have
Windows Server 2025 build 26100, and in my case the host is a Meteor
Lake.

I'm running my guest with

$ qemu-kvm \
   -M q35 -drive if=3Dide,file=3Dwin2k25.qcow2 \
   -cpu host,+vmx-mbec,+cet-ss,+cet-ibt -vnc :0 \
   -monitor stdio -m 8192 \
   -bios /usr/share/edk2/ovmf/OVMF.stateless.secboot.fd  \
   -device nec-usb-xhci -usbdevice tablet -smp 8

However, the trace shows that CET is not used at all unless MBEC is
present. In particular (after "trace-cmd record -e kvm ...") I can do:

$ trace-cmd report |grep  -e msr_write.*da0| sed 's/.*kvm_/kvm_/' | sort -u

and it shows as expected this with +vmx-mbec,+cet-ss,+cet-ibt:

kvm_msr:              msr_write da0 =3D 0x800

but not with -vmx-mbec,+cet-ss,+cet-ibt.  This initialization is
performed by Hyper-V even before VMXON, and the breakage happens even
if Memory Integrity is disabled inside Windows.

Knowing that Hyper-V was not running any nested guest at the time of
the hang, I changed __vmcs_writel() to have

        if (field =3D=3D SECONDARY_VM_EXEC_CONTROL) value &=3D
~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;

which is admittedly a bit blunt :) but lets Hyper-V use CET, while
basically undoing the effects of this patch for non-nested operation.
This also hung for me.

If possible, could you please check:

1) whether 7.0 + patches (up to 22/28) also causes the host to hang?
2) whether 7.1 + patches (up to 22/28) also causes the host to hang?

to understand if this is a) something caused by our different setup b)
a regression in 7.1 c) something caused by the last 6 patches?

So, while the host hanging is worrisome, this seems to be caused more
likely by the CET enablement rather than by MBEC.

Thanks,

Paolo

