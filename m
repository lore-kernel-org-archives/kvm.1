Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646001;
	b=mGPERzqCGYpEcW8Pz4ovXKWoCfKk4HEXTpfyro9Wl6Cm+qDBdWut7HDpb72nOYq8DSCF
	 FaLEojHSN8+VbZwfz07JJbm6l0OUHGSBM3NKnOgHS08OieRvYl8R5JtKLQz11Cg9kgbZt
	 NvAptRYIBBmx04WvE3LhT4Y2VznV+US04KdkXTCG6ROcBJ4O76DSXgUiCqG8pB+YBbZWU
	 1CiEreMayyAcKWh6TaM5ogMgChvtvH/+lj4oBlMSt8iYkrFtjh+9+5OY6E0o9bys93pMU
	 +6qUjypEVOUzUegLlZfmNK2MKwpY0mtWxyzYqTmDCiTfI8jMaLtwWsUI9QD3F+SYexQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bfaMKXrWeYRP7WEXgxdER3J69Id6ZxO0KCbiyzPfHr4=;
	b=r22chHkJD80a2of43Kmvql95C5D0caIov6gpNCTZvzak/KKR2PfjFx7CN+Owrt9iDEBP
	 K0USiFYVNENF0/5kobDlThD3TwjIifQUpL4rZBrqUfsHXU0uImLmZF155KmQxcTO97SQK
	 fIKuKJU44zhUSUJu01zwKtiLiJ1eq/Z7/wyi4fmd+xeXvLTef+7290WTU1Dy5K1VqakOm
	 2imnV3zHULbidumB7GVQu99AX9/BJHk2NXVV5ZdRxYNJRsAlPVXcQon0tQEbnzauifUJm
	 zIU1ssPKFEsnskR1dx31FtOTfL8GnYW19hHA/7Pmx5BZoONGnQhzBOAtxyGokL2IEaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gazn9V0g;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CB606A33B
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 19:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87CB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gazn9V0g
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e940d5d2beso12817025ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793646000; x=1794250800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfaMKXrWeYRP7WEXgxdER3J69Id6ZxO0KCbiyzPfHr4=;
        b=gazn9V0gavccqS31GwskuSH5hBz4+XcaBgNZ45uO6x9kza4ppiYg472YGcD+WxWSSj
         3VjLmXFgZAtUpzMDPmc2/XyxFAiBRQzvXqAuh5n6kS4P8z+Bhzqh9y8JVNA2SN7hPXON
         /zom/oK+IZKgNe7Sks59Ax3L3nFiw5J9y/NOttcSbLEmM6a8PMmzt0Ohs6Z5h8ak0GsB
         gsEqLx1+F0h3bJ/MSUD3fWcXtGM9oD5k88y2qmvLT4dhh0jLMJEjj8LuRwn+FIXX8cEH
         Gl/X+XH6C6CyA3qRfATC2Y855g4/amVu8Nsq5116PMpH8ECys/lQmD8a00XVSgO1JMJ1
         gkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646000; x=1794250800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfaMKXrWeYRP7WEXgxdER3J69Id6ZxO0KCbiyzPfHr4=;
        b=DOPtdsUGFwItSo5FmIXaWx1jdQqrDxahuO9Gw26Iylig8YHZ02oaiCbwudOkrr+K65
         cq20HKi1C+hOuso9CNlK6pdqHKej9VOGN3keOY3c1M5l4bNHmi2yEXccihKTpxBlz/+m
         celqpwNXjgMoUjlD87OhvEgNv9siyoPyFbLqD2uNy05Tk9IH9NH5H1OTwVh8HPpatChn
         +r0PEdB7QBvqLd+ZtlHJsjqhlKrnsXKcRa4OalK6YeZMxwlGTq8SFidcplfM8c89jx1x
         p6MnEVZt8IEvm2fKCA9z88Xlv7TsW7Q90OvSrqWFZg++m7ueDtRRqLcn96J8D0rDcZk/
         VMYw==
X-Gm-Message-State: APuU4Z/R4iaABC/kpl+uffbFA0/aReXCoFoib0BGNtmRXx4m7IZtflBG
	ix0wp734bqEXBptpKx0jaUXfzlGHHmA8pVOlt0uqWvQkkCl/LTCaVvGEZCWGbFGZBQ==
X-Gm-Gg: AYBFou293i8jtobF5Kri3GRC0ooQy4C+iseafgBLUmWuWLR/z3su3c9WUwlmlIFK0Y9
	FaIQyP5SuqmUet0r8mysfSrIOwzLWCw2FNA2b49137V91s2Rea2qFY3stTKhlcAa+QxafER7nhP
	zUzYLV2Y9tCPZF4/XQobLNn191hR/bpoOqFcrPn8ZC+xcl1f2xBURdemnFg9er06nRwN+P1AEdd
	f/Sz9w0Q4mJyyDvOY30n6T34BH61H7M1fPcEw9jX45q2B2P8Pvgnm2Rzk1+qNkUMDuIpyzkSA2v
	qHx0InkS0AorUGbvO2QwQVTSh6V/TRYKCiJiWTmKvxp9RcF9ryhFxiq1u/xuUWuRF7okRcgnTOy
	qWrmEO4lFqDZwecYIUseKiu+QB5Wp+pohJ5KnGEeVyAldoe10TTc1luc2QKSi7bUjNXscM5/cdT
	N4mMwYe3BYA2imyrHO2ZygkS+vIasluBgFIXNn8HVUwxbleqiTgQDNmkRkG7qqVvi2dSADywa71
	qXxLzWrnVCVly5LVlNoKd6qsMrFPIgk4j9NodlbMNd/tuOzOjWZ7NvY6KBZS3X74giKDk1FCGnZ
	+I02siNAzPrn/2UI5IUGyUXumce2OX1rUoj7SRWQDToj6euTWmdLDlklNufi9oqH
X-Received: by 2002:a17:902:d60e:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2eb3644fa20mr96025995ad.35.1793645999714;
        Mon, 02 Nov 2026 10:59:59 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392b15f0sm32087165ad.73.2026.11.02.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:59:58 -0800 (PST)
Date: Mon, 2 Nov 2026 18:59:55 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/3] KVM: selftests: Use VFIO selftests library to pick
 IOMMU mode in IRQ test
Message-ID: <aujdq2fsyt_xRGGV@google.com>
References: <20261029221710.1871112-1-dmatlack@google.com>
 <20261029221710.1871112-4-dmatlack@google.com>
 <auinpIEk6FdGwDS8@google.com>
 <auit0kVkAaWcNUvk@google.com>
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
In-Reply-To: <auit0kVkAaWcNUvk@google.com>

On 2026-11-02 07:35 AM, Sean Christopherson wrote:
> On Mon, Nov 02, 2026, Sean Christopherson wrote:
> > On Thu, Oct 29, 2026, David Matlack wrote:
> > >  static void help(const char *name)
> > >  {
> > >  	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
> > > @@ -266,8 +250,7 @@ int main(int argc, char **argv)
> > >  	}
> > >  
> > >  	if (device_bdf) {
> > > -		if (!iommu_type)
> > > -			iommu_type = probe_iommu_type();
> > > +		TEST_REQUIRE(iommu_mode_is_available(iommu_type));
> > 
> > This is very unhelpful when neither IOMMUFD nor VFIO is available, especially
> > why the user doesn't explicitly provide the desired mode:
> > 
> >   # ./irq_test -d 0000:6f:01.0 -i 10000
> >   Random seed: 0x79d386bd
> >   1..0 # SKIP - Requirement not met: iommu_mode_is_available(iommu_type)

Agreed, that is not very helpful. I've added a
iommu_mode_unavailable_msg() helper to libvfio, which returns the reason
a given mode (or any mode, if NULL) is not available. So irq_test would
have:

    __TEST_REQUIRE(iommu_mode_is_available(iommu_type), "%s",
               iommu_mode_unavailable_msg(iommu_type));

which gives:

  # ./irq_test -d 0000:01:00.0 -t iommufd
  1..0 # SKIP - IOMMU mode 'iommufd' is not available
  # ./irq_test -d 0000:01:00.0
  1..0 # SKIP - No IOMMU mode is available. Is VFIO (or IOMMUFD) loaded and enabled?

> Side topic, it would be nice if iommu_mode_lookup() printed out the known modes
> when this is hit:
> 
> 	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);

Will do in v2. And I will also use the same helper to print out the list
of known modes in irq_test -h.
