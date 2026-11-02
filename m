Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633748;
	b=gwvDxsEJjwYLCxztWOMLVzDesBThFSOB7NslnlJ9WMX4603uqeb3KUzon6+7ZvgJFdDI
	 RVbKGyLdVkBta1KZgHXWQqH7uPSiG4wpT/dN7cVROZ9Oyx8+JLyHfwikJUBDkAjlrTIwL
	 bRuNnYVzSPqsbFmizVtKDmNHanldI2fEEGYX5A5tjzM9lvRgxcmII07GENLlzq3pIQixs
	 yqWYlo2GcJfNrOC5diBwAE/4iZLVbLmpi/UO1jHQZAZa0DFbnaxOxuKBUp05BVd+j4HrS
	 s6bw2dsc9qqfRZNjhDjG547egBOosSJY6TcvzB+KVo/aTTn2JVcjZ5dajSb+/Vm9NCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uTBY7+w3GJYj4zEYkLCYx6G9HqVrLIEyic17+kRkINY=;
	b=zLuUDD4aT70ANzGeXbi8uGdywrn0xDv30MOikcMJ44rpbykuS+rF4Rx0mEkDpYHEPMD2
	 huS+gx1ccPk02JTaR4RXpB3U4501T7ZhHCTlK//WPxvcAjr8B2evBrFXwpf/zu+2x8RMQ
	 Ce9NQTnHWaawPddpCWV+mSVxKwvbeK28HDKWKLEYLbuLhUZCDRaSXHsxizyzxNCu1QA9b
	 PR/4Onu/FBbWdoKRGiGrNAiEcRZXvCEOeOd1DRFb42xPnn3sH1zvztnToNukuP4khtY9S
	 6PZxLQc3ONuozDeC3NHM3PN+LrwokFXl6XPhOpSayDqVor563lGgFvHKPE30SFx0HaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BlmVTSs6;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AA60A188C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B73AA60A188C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BlmVTSs6
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so3244748b3a.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633747; x=1794238547; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTBY7+w3GJYj4zEYkLCYx6G9HqVrLIEyic17+kRkINY=;
        b=BlmVTSs6+8o5sfMbktnXRJo79MWSCnhJCKAoKhAbRQ8bSIpJFiwulmzOLhAWahp646
         BsnUOI4d6ANJJUu+YsiQN3+st++LgVoVRAjB67Q2gUzV+X6JB1BzEuMmyChazFLbIJwm
         +1tXtAr5r3ZPNL/UA3s/L9d/8C/OCoBFw3B2S/Rx092lPvMJjvkrSCwoQHtYk3BaQy7r
         LvT4HBuvfbEJC8sDDzCbuieOV0pAJ5ck/XnXONH948n65c6oj70iWGTC19BI5BLf6RPL
         iFel2n5OR68U7V2FfaNuWr9KY4HZE2Ig3R7yKM8ckCNkvNZS2/4uPzjqLofCaZc6J2D6
         nJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633747; x=1794238547;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTBY7+w3GJYj4zEYkLCYx6G9HqVrLIEyic17+kRkINY=;
        b=fNK5vbRhpdbdZtEfHvrmQL9pPU1ms6xuZwVb7kP3czgCb8dLVYBVQxYrPQPeeKVaaC
         oiOusc9gDgbpwNV9qtyVUI5cY0KkG5a3cIPylbCXZ7OcQNwQFeOY58pIUvXUoXrivbq9
         rWE7j2HzoDlqmzdkBtPChka9Y3suoNUgEfjpu6wFmOEVzOrpsH9TPoTKpJd9PYd30do4
         Ksx4LZKXmSgATp1PWFt5+iEiokItAniJ9Xs2JTTeAmpowaE9LiuEqNtqKhNoT2KEhOFz
         UphhWzWG7TwPgwTdp5XBfOR8rn2HKPBUEy/tR8iQLf1zAvvGsVPbH5/mbqE4bmdSwuax
         kc+g==
X-Gm-Message-State: AFq9FYI8rW+sk7yQSjh8nVYw4X5r35djVhWH48DJRWhU/iEaNixqE59M
	eKC5yUOp/OnGInVgDL8eDu9PCiEaMctbK5ps0nmW/AMdlbD25GbXWEhYK1jkoUAg9mvUrm0T6ox
	gmntZVQ==
X-Received: from pgdo12-n2.prod.google.com ([2002:a05:6a02:620c:20b0:cc7:e6a9:8fe1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9185:b0:3e2:6ee4:a751
 with SMTP id adf61e73a8af0-3e928a5a7e7mr9816324637.60.1793633746886; Mon, 02
 Nov 2026 07:35:46 -0800 (PST)
Date: Mon, 2 Nov 2026 07:35:46 -0800
In-Reply-To: <auinpIEk6FdGwDS8@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029221710.1871112-1-dmatlack@google.com> <20261029221710.1871112-4-dmatlack@google.com>
 <auinpIEk6FdGwDS8@google.com>
Message-ID: <auit0kVkAaWcNUvk@google.com>
Subject: Re: [PATCH 3/3] KVM: selftests: Use VFIO selftests library to pick
 IOMMU mode in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Sean Christopherson wrote:
> On Thu, Oct 29, 2026, David Matlack wrote:
> >  static void help(const char *name)
> >  {
> >  	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
> > @@ -266,8 +250,7 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	if (device_bdf) {
> > -		if (!iommu_type)
> > -			iommu_type = probe_iommu_type();
> > +		TEST_REQUIRE(iommu_mode_is_available(iommu_type));
> 
> This is very unhelpful when neither IOMMUFD nor VFIO is available, especially
> why the user doesn't explicitly provide the desired mode:
> 
>   # ./irq_test -d 0000:6f:01.0 -i 10000
>   Random seed: 0x79d386bd
>   1..0 # SKIP - Requirement not met: iommu_mode_is_available(iommu_type)
> 
> I helped write the test and I had to go read the code to figure out what iommu_type
> would be, and then read the VFIO library to see how it reacted to a NULL pointer.
> 
> How about something like this as fixup:
> 
> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> index f9c11d80a306..63205afc04d1 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
> @@ -250,7 +250,9 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (device_bdf) {
> -		TEST_REQUIRE(iommu_mode_is_available(iommu_type));
> +		__TEST_REQUIRE(iommu_mode_is_available(iommu_type),
> +			       "IOMMU mode(s) '%s' not available",
> +			       iommu_type ? iommu_type : "IOMMU and/or VFIO");
>  		iommu = iommu_init(iommu_type);
>  		device = vfio_pci_device_init(device_bdf, iommu);
>  		msix = vfio_setup_msi(device);
> 
> to yield:
> 
>   # ./irq_test -d 0000:6f:01.0 -i 10000 -t vfio_type1_iommu
>   Random seed: 0x14e21328
>   1..0 # SKIP - IOMMU mode(s) 'vfio_type1_iommu' not available
>   # ./irq_test -d 0000:6f:01.0 -i 10000
>   Random seed: 0x160225ae
>   1..0 # SKIP - IOMMU mode(s) 'IOMMU and/or VFIO' not available

Side topic, it would be nice if iommu_mode_lookup() printed out the known modes
when this is hit:

	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
