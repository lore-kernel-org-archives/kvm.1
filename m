Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446691;
	b=JWhQTRJ/wnHf9JUN78qWof5A/kaAUwzs1ozsiRO1366zHYhrsh9yJNQuOf6CO7wvQyQe
	 fBHJebAsmc1aMcGKMOiyl9ns4cTbrojuGDcv/TdhGc8Pci9PXiWT067Np/rXZ/ayDUHZ8
	 /5sXuk7/+v1aG8e57BbNn0fHB7SDVLE0okPxDhsDbb4zU8OjlZbOhNOkobvEHH0Vi7ebW
	 ksWwTi9YmLvx27/tfrb5bLhM3I/kbq/uPR3Fb/QNv5KiiLIZ2XE2jLvJTHWtjs0/QV0Yn
	 NL+P8S1wsbX+vp3NMWGZ5v5xRc9jvJMG9RIXpd15afY6rsH7n7BljCGbhEiFxmbFRLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S6J608SnbhlVzTHO8nTfTbyQzCC0Wef9AXmftuQK8FM=;
	b=n+WCP4HSAvD9ZwmpHeTldsRu0BXXf8dwAm7FKTx1quZXDQKE7wZad4oUAkb16ZM1LdtJ
	 yX/x/hTwJU3LK/18YGrTr3wl0ixtJCox5YjqnG7xVRSKoxYAtLgVOjZbdFs2mafRQF804
	 K8SKuyXgHfcp/Jtvhx4c6ktZh1CGveN8hcrBb9uBdusM+Hd0Nigf4NUAZwTqeWNNDJ6KZ
	 8XpQohNeyBjgPi/uaQ2YmulRqGkfZgUEstOtbZER19s1SwiXz7h/JWBZyM69I4hPGBB43
	 3x8i3cRrrJ+dxiuoJpBznFrExRyOHQoWJDIq2mYtFTI2ZQE6DgKEITq2gpf9cIojq3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ULnOCYsQ;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD0606A681
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAD0606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ULnOCYsQ
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-92100b756b0so29393726d6.3
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795446690; x=1796051490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J608SnbhlVzTHO8nTfTbyQzCC0Wef9AXmftuQK8FM=;
        b=ULnOCYsQhWIKDt7pAFJxN5BdezB6uuwO2wH7M3H75HnvcnHu0ePPTzZKt+/E8HJbsq
         8xNQcunddG9jd5Lyy5gXDUoI6tNcqkgliwQBuS09bcwR4F/99g5XmNioCqy1g81xleyk
         LHhAxO/sQfFLnE4JLEDu/YBjhGAidQN37cDWd2dzzVWGUITLsdgtKfpXw8jO/nNEuElh
         tyEhFp/7OKJTeRItfxiGqKUkSnpdV0wQ/c4bCV2HFB7OEb8h0vw3dWK2Ty+VuV9E6Ewn
         yDkmNQkEnylRuyYGR1sqGLaQPOKxcWwfhEHqIAlHska+tD6+MsFsnDzdHU0merc4Sqat
         NOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446690; x=1796051490;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J608SnbhlVzTHO8nTfTbyQzCC0Wef9AXmftuQK8FM=;
        b=1HI75T3YabTE3flyJn17KrfX1Ed19U3kCwWRa9TT0I6NUNrxMVummPpI6wvhTedtfJ
         BPwj0Urr3inSXIOdLZ14+qAThE6SYinofV9W8/z1UXakH8+OdEOFhRekXG71aAhxovfb
         +uT/FeJROox7AWEwez4fqttGek3lUig9DR6C9nswY+YDX+VYKXB6b1/MNtDafo6z713O
         gvSjX3+RExMr/vIpilJbx4/p6xztUKk4Cz55XxI6g8zRH79qaDmqvj0PgylAtLmYSl2v
         sxIHXo5ZTghvDuOELGxtY10I9E1skUqHeBEjl/uKr4CrXOKzm/CqNaONqTjBGHP0SY2w
         8q0Q==
X-Forwarded-Encrypted: i=1; AL+hErF68tdzK+NJ5PJUA6nARQ7ZMJyCYvhXUIFygEAy5AEmDnC7Fxi1v2jFoQKEJj9JxKgMOfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+lG91Dmfa5wZYIGaRs0s8MogtgBHy9HT67ghvlzBeFE9ifx7c
	BXLGWByV9nwZdIBMSTuqvsTOT0DUY+T1P8/kuYpvvaIqqLcJKjqYUIuyMgXQ12B7mOQ=
X-Gm-Gg: AZFdTZfzbSWTorQ6vnCGkkDXqWJcpgUEi4erohUR260AIHe+MRrWz4QzGbDyZA7boY7
	/cF1f2oXdRdVs86+tVhlyD+qj7oxTAE3m/Oh79LmglJj5mvJFUhP8+1wwQXcWv1ujPPbP3yy9L1
	6DwC4K/6s1izE6HKwC5+H/87wSQsWgg05WXA4QBg1q2RvEWmQRCW3DUdOfCfuTr4RcVVcCezguE
	mmF1z0Se6Dq09WTf/EqHR+EXChT3+sTekReAids86MiySaN5XwKA21Vmxzl/m2hM8U8xfOYE5pr
	hHk3d5tbenlslN+S9JzegWCPPEcrVJUkF5RZDPQ/mg7PJlBLvby4ZRHNIypLeLrg2ftYr98p/m8
	HTfd1iGS/HLi70eGMibIAYlbpe2zC/S8Cxz+0HXhO6f8a5SeelXhizRKlBmCx0G9xjQwNKsmhQ4
	8I5FNBg1kCzBuIQv6Oj9P3fZ95iSnsZDm5c+o0yqipxQHDpAKIWQDVmiI4Cp6SRwAC0vmrdN/eq
	ONe6OvrdRKA/YPPz2Ifx0yPnYAulvqiLzm8a3NWbnSqIQYuiRD6g7xZYpCA7Hvu+PtDP9xMTSTx
	goLMKqduqbwov7AU5GDpNdOCa4vJj82SVATqGGLcpCTOOQS5vhPpSgur+Zu8sZr0a9p09NiJsNn
	ENKc=
X-Received: by 2002:a05:6214:4108:b0:921:266f:50ff with SMTP id 6a1803df08f44-92134b3f207mr208575596d6.52.1795446689538;
        Mon, 23 Nov 2026 07:11:29 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b50besm106533186d6.9.2026.11.23.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:11:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVhY-00000000ro7-1hOk;
	Mon, 23 Nov 2026 11:11:28 -0400
Date: Mon, 23 Nov 2026 11:11:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com,
	zohar@linux.ibm.com, aneesh.kumar@kernel.org, dave.jiang@intel.com,
	nik.borisov@suse.com, sergii.dmytruk@3mdeb.com
Subject: Re: [PATCH RFC v2 9/9] attestation: Add the TDX family implementation
Message-ID: <20261123151128.GD179082@ziepe.ca>
References: <20261113160838.2512652-1-jiri@resnulli.us>
 <20261113160838.2512652-10-jiri@resnulli.us>
 <awQCrnD5CtEhKRWz@e129823.arm.com>
 <awQz1P6iXYrL8lv0@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awQz1P6iXYrL8lv0@kernel.org>

On Mon, Nov 23, 2026 at 02:38:44PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 23, 2026 at 09:09:02AM +0000, Yeoreum Yun wrote:
> > Hi Jiri,
> > 
> > [...]
> > 
> > > +static void __iomem *tdx_attestation_log_map(size_t *length)
> > > +{
> > > +	struct acpi_table_header *header;
> > > +	struct acpi_table_ccel *ccel;
> > > +	void __iomem *log = NULL;
> > > +
> > > +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_CCEL, 0, &header)))
> > > +		return NULL;
> > > +	ccel = container_of(header, struct acpi_table_ccel, header);
> > > +	if (header->length >= sizeof(*ccel) && ccel->log_area_start_address &&
> > > +	    ccel->log_area_minimum_length &&
> > > +	    ccel->log_area_minimum_length <= UINT_MAX)
> > > +		log = acpi_os_map_iomem(ccel->log_area_start_address,
> > > +					ccel->log_area_minimum_length);
> > > +	if (log)
> > > +		*length = ccel->log_area_minimum_length;
> > > +	acpi_put_table(header);
> > > +	return log;
> > > +}
> > > +
> > 
> > I think we don't need to dump log area with the log_area_minimum_length
> > since the area would include none-event otherwise, pre-exist tool (i.e.
> > tpm2_eventlog) reports error for them like:
> > 
> >   ...
> >   - EventNum: 21
> >     PCRIndex: 2
> >     EventType: EV_EFI_ACTION
> >     DigestCount: 1
> >     Digests:
> >     - AlgorithmId: sha256
> >       Digest: "b54f7542cbd872a81a9d9dea839b2b8d747c7ebd5ea6615c40f42f44a6dbeba0"
> >     EventSize: 40
> >     Event: |-
> >       Exit Boot Services Returned with Success
> >   ERROR: corrupted log, insufficient size for event header: 3
> >   ERROR: failed to parse tpm2 eventlog
> >   ERROR: Unable to run tpm2_eventlog
> > 
> > 
> > So, what about export *real size* of eventlog like
> > tpm2_calc_event_log_size()?
> 
> Nothing in the patch (neither commit message nor any comment in code)
> says that TDX attestion registers share the same format as TPM2 even
> log.

It comes from the UEFI spec's definition of CCEL:

 38.1 Virtual Platform CC Event Log

 If a virtual firmware with confidential computing (CC) capability
 supports measurement and an event is created, virtual firmware should
 report the event log with the same data structure in TCG Platform
 Firmware Profile (PFP) specification with
 EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 format. The index created by the
 virtual firmware in the event log should be the index for the
 confidential computing (CC) measurement register. It is CC vendor
 specific.

It makes sense that the kernel would size it correctly.

> As per the function, perhaps tpm2_calc_event_log_size() should be
> relocated to lib and have non-TPM name like firmware_event_log_size()
> or something.

Probably under drivers/attestation since that is where all the TCG
formatted logs should end up. It should be 'tcg_event_log_size()' or
something. Maybe a tiny module for it like we would have done in lib/

Jason
