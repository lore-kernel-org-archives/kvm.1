Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794231504;
	b=VJoe82RydfVj+C+CCyXXb28+Eb9vBe7df/tVMTUuF0ou99TP6ideZTSmuef144T80Vcv
	 +YEsUdxHz1GT/bL3Qkk0hl42te6nQuy6X5yqrwkXRRaNna2VFcT80iwZG/Xy4AKU/VGm5
	 Lt0NImEmZ1fkAb8jSbM/d9drV6LahaLM88A4Ny8POoFwFzA77PJHewxs09hYPqTqFBmpe
	 hEHUAzzYME/yk3yaG5TN5sW18eY+6JJ1rejcNcwYRd9oLdXRCufEvuTilo73SF0X5/oVc
	 oypHYwWAesz1MzwkjNkl3Kb6f8FsdxfrIc+VaeXrOXMMyKQ2rsaU11doPzTGyFdeyLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231504;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=lXq32ONpn7iSK6Jn0nq5xHZeZlK2E+qth6t81Iwx43E=;
	b=yyveyI0eegkcjxyQSL5ID0tj9JYCV1UZbb64xWgwbR9rZHUETHEX9r7kZP3G5wld0Dey
	 AoPVr0dFNG1EPM9ixFsoN78m0WN7ui32CvG/fyz+cVNNjX4h1Ro8pOV6Id3dlT0TrLwGZ
	 3NePxOZdn4TUvD2CZJ5dkixN3L9n6oUXA2ECqWorvxzJdp+IaDAsrqCZ25O1gg0o2dp8F
	 L/ANHHa+hky3S1nqXwl7QybHGpJo9BKU+YTtA3dMERPlSuPgynnFuY1pINi9fliGhPfeq
	 aDRMy6lCNnojSZRsHT7PBV5hQC8whRZRqNc+9qPYlCc1sAfgVImtTIGwh0ViPsHnkoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NAwqCeil;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qfrxj09a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9E606EE9E
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 13:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F9E606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NAwqCeil;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qfrxj09a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794231502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXq32ONpn7iSK6Jn0nq5xHZeZlK2E+qth6t81Iwx43E=;
	b=NAwqCeilaRtAcwDrTv6HXPt+qjHCWTSR65GsvA9Nv69b+GpWlNGIbumgu21DwtNJBAhEMs
	6ay3x2rxvwTrAP0fabvEpER7+A0YphY9n37HT4gpFKVexejAy9I92EaRfNIL5NZbjVVCiY
	YueqBp3ZWf91Al2MtRardlgPwLgFZf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-6bAwrlgoMPSBVHS1RWiXyg-1; Mon, 09 Nov 2026 08:38:20 -0500
X-MC-Unique: 6bAwrlgoMPSBVHS1RWiXyg-1
X-Mimecast-MFC-AGG-ID: 6bAwrlgoMPSBVHS1RWiXyg_1794231499
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so7331005e9.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 05:38:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794231499; cv=none;
        d=google.com; s=arc-20260327;
        b=PpF/6Uyo4233LMcPTWp36/+uimXc/3OM5cMdzuol3RQ5FZtdByB+TZzdVq4t4kRpJ1
         Tt0w0S6ggJk4W7+oJrGSTJf0XjOADg5pcE9lXQq4ZDSft4CRgC8Rpe5c75pFE7Sf8HIg
         YYWPuT9Zvr2rXJNiK0IHN4PdEpdQv0u9N8GR7XcgXhbplfW9OuE1IhVmTvaQY0aY0Biv
         jzbvq1ihW9zWbtDUgMGbAhyglxmNSLWwi2WwRNQWr44TdsZ5SLh98Heha1GVkB7W1vUg
         FcVEz9Ge4R7JMve0A1rub+73jCASowY2JJDQBg4P/Np4rrk/D9XexGFWjqFf57vNFvwJ
         +/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXq32ONpn7iSK6Jn0nq5xHZeZlK2E+qth6t81Iwx43E=;
        fh=DSgFjz6/347fxI0frOMrFJbY8ncNpagK1kllKcNsspY=;
        b=pMkbglWrAYcAU7t3jDsejEaW6d61axI/iGC7AXf54YIaSI48fLKnu5awRqu3334FwY
         6tMXFsqxI2/+ySblBgwj4EdZKu4QPrh7B1vdTcnFr3dXpjkq2lTtIHzYc0uTmqAJEy+Y
         sJxh2GZuv7oI5CmzM4Q41r9qZSBLbod4llK1ePhoaQKcuVCquyyzp5fI5cYRG/QcykyF
         A2UcItozoq25mj3OCAL/rZ3/VNLvgzxZYdqRJyMz1WeGPoUvOC+iK7y8llEmw4y+T3v9
         UTpegOUJ45Ze/qd7O6oD0hRStXhfQl01XsfVgvBV5ihog3dwDmojYFE0uX5Kq6Xy5zBv
         qYCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794231499; x=1794836299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXq32ONpn7iSK6Jn0nq5xHZeZlK2E+qth6t81Iwx43E=;
        b=Qfrxj09aznKEdDSmmr2VJ5KFDnLFHWzmM9xzAa6oKtp4+i9IYuAiAKDIW9b0zW8652
         HuuuEMcN4m/LcbmJGFkkeZKckCNa17Pgd/q4CknWJeWboFnDPbP8UdSiXTqcNS9ECT5Y
         GQuEPEhlDaDinxiC7LLQ2Zsv8zrLt7lbleraRPOKa12DRUG/jRRrO+gQiKhkS8YKUJh2
         T/60mul86g3jv1kwYkmnkDazs49SFOelEtkre/h4eyys0d+W2VNFUVZROTGHcfWXiXDb
         uqxxYbzQU2HBNytC2Bj8IvYjKgEMAZfFz39ALGu1bkZriCxahwTF3LdQBPt7dJAu8L9F
         +qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231499; x=1794836299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXq32ONpn7iSK6Jn0nq5xHZeZlK2E+qth6t81Iwx43E=;
        b=n/PVcIRLjv4T0LkuoiCZt6d6hx5rF4fHtK+4GBVLY0T8I2Fjrz43x2yeLJCwvE2jml
         9fPI1Rkh+FLYhK0pOon1TG7HHGtg/RTC2gOc4e7RJKusJwV7IOavbDI1osmQTVR1Tb92
         Pb20h2+AFeBz3+7jySSyhvldOuMnqQRRv+U/CF7be4cZ1/q7sDZjbxh4CqwI/nD9/zfi
         sPrxQK7hkK7YGk3yOIagleKq2zOCSeZFR8WSqgQPIeLFvgkMcYioJf5SHG6gTmSaD6e6
         4kIiZ7miR9ucqvY3J/70TIoJtzFAyV+nijTnS9pXZqrx5sdIbPzzs/bVhfZXrsU/t+bM
         bErg==
X-Forwarded-Encrypted: i=1; AL+hErHBmi9GEz8wcNUskVzIHwR71Xm42GAcB7yAHORt9bJpmUjm38dkQFgL9hnP3Uq2tNTKZ4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RV5XxUdoFxRwi3MGgfJ31TnRwzgc2JpBV7nJZcFVmrfwx/1lc
	5kHPkzpdrYJzPrhjA7r13b+43M0d1bgIwn2YVTpEix3l8Su/DApJYTvSX/h2MSR72d0KLzONQeB
	HKSwLIEKS70APS4uZjUMNSD31fw1PlVrYS/FgP8NCAHj1YTi3rPa6Na18LG1Vya0Tksnhm8Mnfh
	wgIe9YYbKgp/vFf1DEpqsPXbyYDQJY
X-Gm-Gg: AYBFou04sqjo2Ol62/SdXu/8YVV8jfpLF7vYQP+vHa9pTNe0NL5H/GR5WNz01jBtceP
	1IJhU9zlkU4lCt28ODm4CYvetFAgpsuKxdJWysBYif96EiTbEyMhRS2YMzJrBjW70Zu2H21vNU+
	dy9wldTH0sfQWolBFZ+daox/VZsOCJxuFS7yeAuX+pMb8s7PXdJqBC+ah2OfNh/fIE8ALYrdWgg
	/m9BGVGmn2cIuC441VI6eAKET1KPv3Gritbpk5/+ppEVtK20CpM49l/NwfV
X-Received: by 2002:a05:600c:4eca:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4b94d7630d0mr74657165e9.2.1794231498833;
        Mon, 09 Nov 2026 05:38:18 -0800 (PST)
X-Received: by 2002:a05:600c:4eca:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4b94d7630d0mr74656835e9.2.1794231498443; Mon, 09 Nov 2026
 05:38:18 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <58dcd595e3187d335e103a042d196cb7@panayotis.com> <au0VAbk3tXDy0p0W@google.com>
In-Reply-To: <au0VAbk3tXDy0p0W@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Nov 2026 14:38:06 +0100
X-Gm-Features: AclHuK_wQDBNPOMtkxqE_sE8dyg58G04Rzby-vr1WutUHPmk1KvsjQYTq-JOH_c
Message-ID: <CABgObfbXhR7i2Xj=sqky3CJbzWeneywqYUAfW4EUqQnhcj4=TQ@mail.gmail.com>
Subject: Re: nVMX: Windows 11 with nested Hyper-V fails to boot when MBEC is
 exposed to L1 (7.2)
To: Sean Christopherson <seanjc@google.com>
Cc: Panayotis Katsaloulis <panayotis@panayotis.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 12:45=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Nov 05, 2026, Panayotis Katsaloulis wrote:
> > Hi,
> >
> > After updating the host from 7.1.13 to 7.2.9, a Windows 11 guest that
> > runs its own hypervisor (VBS / Hyper-V, hypervisorlaunchtype Auto) no
> > longer boots. It fails very early (no bugcheck, no minidump, bootstat
> > not updated) and ends in Automatic Repair ("Your device ran into a
> > problem and couldn't be repaired"). Startup Repair reports no root
> > cause.
> >
> > Hiding MBEC from the guest is enough to make it boot again:
> >
> >   -cpu host,migratable=3Don,vmx=3Don,vmx-mbec=3Doff,hv-...
> >
> > Host:
> >   CPU:      Intel Core i9-13900 (Raptor Lake)
> >   Kernel:   7.2.9 (distro kernel, Manjaro), kvm_intel nested=3DY, mbec=
=3DY
> >   QEMU:     11.1.2 (also reproduced with 11.1.1)
> >   libvirt:  12.8.0
> >   OVMF:     edk2 202608, Secure Boot, swtpm 0.10.2 (TPM 2.0, CRB)
> >   Machine:  pc-q35-9.2
>
> Paolo was theorizing that might be related to Hyper-V expecting PFEC_SS t=
o be
> set[1] (Hyper-V appears to enable CET if and only if MBEC/GMET is availab=
le).

It certainly did not help (and it does not help that
__vt_handle_ept_violation and FNAME(walk_addr_generic) do not
translate the exit qualification to PFEC_SS and back), but I would be
surprised if that is the only case.

We also don't support the SSS bit (bit 7) in EPTP, and I hope that it
isn't something that Hyper-V needs.

> And IIRC, the host and guest hangs from an early bug report[2] were due t=
o bugs
> in the host's handling of hrtimers that affected only KVM VMX, but I don'=
t think
> we ever explained the outright failure to boot.
>
> Paolo, do we have any patches to try out, or more concrete ideas/theories=
?

Nope, no patches to try out. Maxim should be sending out the posted
interrupts state machine soon, and then maybe look at this.

Paolo

