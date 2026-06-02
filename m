Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18F3F1AD8
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410532; cv=none; b=dXm66LXTFVMuGLTDcyzkS20IFyoyp3MKKyDZYD69qWTk638wrsROpvxW3Sxjvpv2jT4LZiMowhSIKbsfIceWHIxEF6BL+ZEoPVHYt+cY9J81fh8wiuOHOHYXsfbyR+QL6c2MFj7WCcJ9XPVZWCt0cAzO5qxNnxsgid2QBG/pBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410532; c=relaxed/simple;
	bh=PgCdkok4gzT4v4tvCsk5v6uloEQGVZR1NF1GdjCisRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIsXYvT/0Zp2TdK0qjHwB7fuqrdQnDLlc2fdkOO9TQdT8rSJ77X1Kp8x/ej0hzaYalZ0cPjAalMr1WnnVE2Q2XdQZFOrG7SUo3sKGq6JCKq0R7Ao/+cDHwyHLukjQ62xd5JNyk1EhlWAmQ/diehskDK6ggDxiAW1C6LNdXEWrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJupJWuD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qzd2gW1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJupJWuD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qzd2gW1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfUjFymOGeqIDcrOYtdmO5pEs/tI3OUL6hwn8Ge8iGA=;
	b=DJupJWuDkKTh3/pxGJchOa4w3647E84G7uUbikTL7lHMtQL4TFpaXVcnvarvXwxujzRn+O
	fMUttsAC5r4bzVdvqmvRkh0TQt+Wi8pnT8LNeKYVCDlR7aNLDFb8Na2DOHwitKqgACzqNc
	PG0SYA+dCZN5vio9TloS40UW6FkUhto=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-v9ams3ZSOu6F6V-3okNneQ-1; Tue, 02 Jun 2026 10:28:49 -0400
X-MC-Unique: v9ams3ZSOu6F6V-3okNneQ-1
X-Mimecast-MFC-AGG-ID: v9ams3ZSOu6F6V-3okNneQ_1780410529
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cea4854fe3so639526d6.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410529; x=1781015329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfUjFymOGeqIDcrOYtdmO5pEs/tI3OUL6hwn8Ge8iGA=;
        b=qzd2gW1I7yWSCXJ5tj5NGGtyL2vtqgroOwScqB691egH+IwNfEfQR5K+/Ej8Q8ERdU
         dwNkrnC2NzZTgWwCeG4FxAlRfKK3XTW490Lqi3w1v5Zu5EdAvzmS+PUVdNl72/XTTPQY
         BSSRp5ka6rZVidDrc32HySfZt0gfs9xPz1Wlez+NYJSgH5peKWiLZDiII7KU/X2dlZ3H
         BXpw4My0QtMbdKPOlI/8H8Fal5NjxpKaur0NA4VtTzGcEo6fa6Ovouv449sFzMKABoEo
         QqKO5Hds3mJAFBGqVzwR2qFhBiE4ddv3Yj5yv9lwvofhKqsquGUk11pqtqIcj23RrZ3d
         Xlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410529; x=1781015329;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfUjFymOGeqIDcrOYtdmO5pEs/tI3OUL6hwn8Ge8iGA=;
        b=KM2HhRa6uxeoxXsxXsF4fzUFocMomnsNJ+MxwCVMYkioDDM9noRDS6fmx+ljUIRPno
         pBfZlbXk4YjW1ecVe6ikamBdwDX3ilgAR6uKJIoPtm1z3/O0hSQEwSkMpX8ZCYYILw3E
         xlLv4Me5so72Y5znxfDst2hq0++m3JXUBaXPYlw4DFiVoOhi82CYjrmur+2xXR5WG5Mq
         ErAZgsUqo07ytrR5flIAd4sE2cdO6e8xbq247yYJ/Ccwr6V3jcHLLXg6nzSrNBnO/N3h
         vn6hrD2BrhJkd+05YKBmUUiQyfF79CSnh+xGydFShNiEg3gwG/lOQXipvKEPY14kBQIM
         eXhw==
X-Forwarded-Encrypted: i=1; AFNElJ/VCIrq9DqDkD3QhoghhPteWD/ZAk7k2ozOxwM7hWs6JaIM+3VTu7I2n/OCmLkJ49SA/9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8vkbb843SlwhwXSmieMA9rzbi3ZC7zRjWLn6p+rI/WOYMHIRH
	EsDVei1JwcPRXYGP60Gg0kZCM/dy8eJ0Tw6bAr4scoxk6APoY8J9BHx5DZFN9ZWTrnYQXeaHEos
	Fu5OFXe6arTZJyQMCEJnx47AnMOtQqUAZdlX+QE9HjUbp2/BVswl9KUOsnJn46A==
X-Gm-Gg: Acq92OGs35cKepl4QVzdLcSN87JSseTirSsmuAPDOF4XN7HaRxsFt85tBpOav9lJL54
	MilYgfM/vMVYvwqzISZz3VaHhWoLhF5RkN2gPjJo7phefEjXq6M+xzCVEMo0AuUmXCGru2mF/yS
	4V5ON2jaND0QFQ4opJsZPbiVppAc4yLe5Nivz16IcA29/kew8gVeHGGKDwAXfz26rZvgklH4fQP
	FzHRx03Ry2vOzcN3DkvWu4OHhcPXAmfq0ZeGA7I5T2Sg/2Ysc7EpaUelhI/KAAQUXCvWDhffsaV
	lsK20W45guqIP/rd3d+Nu719i2dkduqEdaxKRSbiEbwZzwOnHGvNRMVRG2J8w/VvZYyIXBiKveF
	qk+12yaVrGlY8EtOuWS3NLEc7SFJas+VWJOUpYaA=
X-Received: by 2002:a05:6214:20a9:b0:8ce:b2e9:a4c0 with SMTP id 6a1803df08f44-8ceb2e9a7b5mr119841736d6.15.1780410528478;
        Tue, 02 Jun 2026 07:28:48 -0700 (PDT)
X-Received: by 2002:a05:6214:20a9:b0:8ce:b2e9:a4c0 with SMTP id 6a1803df08f44-8ceb2e9a7b5mr119841056d6.15.1780410527783;
        Tue, 02 Jun 2026 07:28:47 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cebf08e2d9sm26888836d6.10.2026.06.02.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:28:47 -0700 (PDT)
Message-ID: <9176c891af8dc496f02c1e8cbef53976576ae7e1.camel@redhat.com>
Subject: Re: [PATCH 20/28] KVM: nVMX: allow MBEC with EVMCS
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com, Vitaly Kuznetsov
 <vkuznets@redhat.com>
Date: Tue, 02 Jun 2026 10:28:46 -0400
In-Reply-To: <20260505195226.563317-21-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-21-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
> From: Jon Kohler <jon@nutanix.com>
>=20
> Extend EVMCS1_SUPPORTED_2NDEXEC to allow MBEC and EVMCS to coexist.
> Presenting both EVMCS and MBEC simultaneously causes KVM to filter out
> MBEC and not present it as a supported control to the guest, preventing
> performance gains from MBEC when Windows HVCI is enabled.
>=20
> The guest may choose not to use MBEC (e.g., if the admin does not enable
> Windows HVCI / Memory Integrity), but if they use traditional nested
> virt (Hyper-V, WSL2, etc.), having EVMCS exposed is important for
> improving nested guest performance. IOW allowing MBEC and EVMCS to
> coexist provides maximum optionality to Windows users without
> overcomplicating VM administration.
>=20
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Message-ID: <20251223054806.1611168-8-jon@nutanix.com>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/vmx/hyperv_evmcs.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_ev=
mcs.h
> index fc7c4e7bd1bf..bc08fe40590e 100644
> --- a/arch/x86/kvm/vmx/hyperv_evmcs.h
> +++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
> @@ -87,6 +87,7 @@
> =C2=A0 SECONDARY_EXEC_PT_CONCEAL_VMX | \
> =C2=A0 SECONDARY_EXEC_BUS_LOCK_DETECTION | \
> =C2=A0 SECONDARY_EXEC_NOTIFY_VM_EXITING | \
> + SECONDARY_EXEC_MODE_BASED_EPT_EXEC | \
> =C2=A0 SECONDARY_EXEC_ENCLS_EXITING)
> =C2=A0
> =C2=A0#define EVMCS1_SUPPORTED_3RDEXEC (0ULL)

Unrelated to this patch:

I haven't paid much attention to this particular area of KVM, but 'EVMCSv1_=
LEGACY' caught my attention now.

According to the Hypervisor Top Level Function Specificaiton v5.0C and v6.0=
b that I have, there is only one version defined,
version 1.=C2=A0
Is there a reason on why we choose to call it "Legacy"?

Also I see:

Enlightened VMCSv1 doesn't support these:
....
 * TSC_MULTIPLIER =3D 0x00002032,

And yet I see it defined:

 EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
 HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),


Anyway I haven't found any restrictions on the execution controls in the EV=
MCS in the Microsoft's spec,=C2=A0
so it is unlikely that it is not supported.

So:
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

