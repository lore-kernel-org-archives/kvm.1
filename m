Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099563;
	b=UCauZUo+nGoeMY8bAKzSBUBrBiI2tJZVruOXdDWeouF0Kb9NKccXIOHCuQrEROIisyx2
	 YC+uJvN0EcdObtL9IhJRg8R/N0lZhszP4IL6ai6QjW+tvXIvfChyRWom1K9zB2Skyh0Xb
	 G6xxwW+6YuEXWdRUbtcy2IQ84kMerJcLkkPrcKOqe+N+Egli9Gt6er6ERVdnNHrJuagbU
	 Ehaua8S1ot5SbRh/AbVjxtObJ9Gu1zJ3Ive3hWB3OY3ij+BxWePg+FqNXRSPXU+XQUJsU
	 f7xhbjT5GEMsv9H4xusJ+OlSy4EAXKlD6RqOYgWRvubQ/ny5RPeQFTCaskCwuGyZSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Fi6Yc5JpDZ57kOsVtX7b4eqrliKH0uv1div0woJH6Dw=;
	b=2h2+8iy6WBCBVhbj8kaSYxeUDJaQAYTMSAcnHIIym8RYKvg19NkXWPvl5S3tTdDmo3ka
	 O4rsy0J384UkjXdE9vH8HoX/MmgTaeE0hrDQqu/8Jn4vz0z9CnQTcStXCfnDdia4z4zq0
	 Lig9cgruV6ok1YQ4//1rioDssqdDiNw6k+vAiLJdzbz/zr2vHMBxITAhnIHXOJD0xRfMG
	 5gTLX6uOPjpQlyUXB+1MTNI0WiqYgJmbiMrolXJs489Y48OmyBLPUGp/vuli0eBybLMPp
	 J0uyVA1vIEgeh6jb4rD/fD2KkzcdSVwwi84zNv7cGtvr+mUq6J4zFYxQ8vgtHkBYAzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RDtnbuQa;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DB606A334
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 219DB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RDtnbuQa
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso2652606b3a.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 06:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795099562; x=1795704362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fi6Yc5JpDZ57kOsVtX7b4eqrliKH0uv1div0woJH6Dw=;
        b=RDtnbuQa5B+IA0YvCwouz6UbdHA5FwFU+ULJgtJYP/z2FBlQckRKbfQ0EK4ggS0Gk0
         VmQ52TIa5MgCtz4vloZY94g61hVaIHujk3MX88UhEURt776d6QNCF59dI3l04yErpVBn
         he7kaoQEwUApP1KcPk9a16A4YbqzfNs/jlYD7kEwbV3wi2YtMsA4CPfYDoprfFkWiCAz
         Z4Ivl4YjUffnUplTxI6Slj8B+v0dVtMMRU+zZHWKG96B3UmEOAjDgTWbgVGXR7kjV7Mv
         EJUQ2z1l+8IWHrG+Zaotp8gfHajNsVeiE4wGmZJIAWLiBrzJvijqIx88qqjSU8oEDxoZ
         OClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099562; x=1795704362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fi6Yc5JpDZ57kOsVtX7b4eqrliKH0uv1div0woJH6Dw=;
        b=VchYbDTmEuu7QHEApp2Caim52ttoL+irNfnJVmeBTzS6WFJ7S41AZEa9DlamYo589y
         wc3NOhlq68RkSG6nfIUdAsKiwTbaFDXYr2Qy6Xcayn8soL72yyCDAZKWDYLYtVqkvWGm
         iPjbxntX2YZHAaRBiscUIkzaxovhI6fNMpHn6/PbpOYwW8S2bQVuVfapKj2j1g2/bNg/
         c+z/1iPpIrgYVRNGeGijsYSv7NvsLzENc80sfEltumqqSUHjdu70dk7ZBoZeQRjcF2Tm
         S+PPiCcG9plhW36e+MEQkPM+sXi0XNXQ+9hVf6Axuiep07ixgUwgJCegCi3UMGqRfOVQ
         yoUw==
X-Forwarded-Encrypted: i=1; AL+hErFpTPB3xGGitUEWnlED6sCKXto0LBZCOFs6ke1zhiCoKwV47mVKSqMeOO3GmC9o144zbeg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BFkTJmvqNnsTD1Wc0SK/lGAwiL3eP2kutillO4fkwi3FmnvFy
	UrhBBYg0PhLEXTVhYZfCipnnzSkHFj5uWmXAaTjWsk4qS5u08L0SiPf0Tx5lpk6Z7ricTlKOCTl
	qq9VHew==
X-Received: from pflc22.prod.google.com ([2002:a05:6a00:ad6:b0:89f:41ff:99c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908b:b0:89f:9da8:1b66
 with SMTP id d2e1a72fcca58-8c5d3e0e288mr5302336b3a.33.1795099562225; Thu, 19
 Nov 2026 06:46:02 -0800 (PST)
Date: Thu, 19 Nov 2026 06:46:01 -0800
In-Reply-To: <CAKSQd8Wcw-DUR_JO9YFw17u691gjNyvySwfhPW_P5P3ik=_tBQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CAKSQd8Wcw-DUR_JO9YFw17u691gjNyvySwfhPW_P5P3ik=_tBQ@mail.gmail.com>
Message-ID: <av8LqXyAklPZ2-rD@seanjc-mac.roam.internal>
Subject: Re: [PATCH v9 20/20] KVM: selftests: Add APX state handling and XCR0
 sanity checks
From: Sean Christopherson <seanjc@google.com>
To: Christian Ludloff <ludloff@gmail.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, jmattson@google.com, pbonzini@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	zhao1.liu@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 18, 2026, Christian Ludloff wrote:
> > Since APX repurposes the XSAVE area previously used by MPX in the
> > non-compacted format, add a check to ensure that MPX state is not set
> > when APX is enabled.
> 
> For the sake of completeness...

For the sake of my sanity, fix your mail client to set In-Reply-To properly.
It's not a gmail problem.  I don't see this issue with mails from anyone else,
and I just tested that sending a mail through the gmail web interface sets the
header as expected.

> EVO processors do support simultaneously
> enabled MPX and APX, with state that does
> not overlap. (And several MSR control bits.)

Until EVO processors are officially supported in KVM selftests, I don't care.  I
am a-ok supporting EVO processors, but if you want upstream to care about them,
then someone needs to take the time to enable support.
