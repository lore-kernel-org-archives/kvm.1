Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0050277A
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889666; cv=none; b=eLwR1+DNvBzLikylezq+K/ju79TSb+XSXww20aZEgLFZK+yM/+6Wki7O2N0M7rNs2g9PTPKugJ2DKqvsQ2NvIReOWAoWdgHT+w51rUim7X6Q6PxWnTPP7/gjV2DU2Pc+9rRRbuNbfdG13Ium5n4VlpXhIjVEsiv0dutiqNWTizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889666; c=relaxed/simple;
	bh=SbI9zuwpLoviGTLgjhQIkxJ0mcfP+lQtKKioVT52hTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jINciH8WHwn8f+h4zlg0+v1ttOkbs4ALhuaFDN+U79ozUWtWn4GxGJ15zVTMyMi+wpJvKJf+dbBU/LE6HwwhEw0VCvbmnrAYmKFSmbnwlBM1tLiwlImZfifgd1ekIhfkYO9RurDEIUyjTxtP2OgSZ4hJTbDSpnePlyy1AOPnpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhTvoUaz; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhTvoUaz"
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-806004ec379so6787644a34.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790889661; x=1791494461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIr4K7N8tWlFElP154T0gDhZmtv6PLeTBLURDyjAzjU=;
        b=rhTvoUaz+E+iJsTSARzZw8S6lz4ltoU2dJ9G0gCdDREV7lICxZkfGfK/b+aB80D9QS
         XQTJSJ10OBersaohxgAAMSwWY8s1ftI7rkEnws4UXcNLgqpaYb1ArpqmACTo3mLaAsmG
         gdjIaJG3Nbf9Eol4x2BgozJnwNsch3T7oEFcGc48bmP9J1q+GLRS6gjlKTKfYByfCcjT
         Chw2MPCkNsar6/F3BqrASOUSkacre+/lK4J5YD4K3w75c72KcJ9mASpk7N+rDJBRLBxY
         8fR/elkj36oUuTVal+aJ4i/Ha3VPaK7w8kADd6oXxGcNiDI/MJxUTJtsRHCJlzHrFoDN
         o2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889661; x=1791494461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIr4K7N8tWlFElP154T0gDhZmtv6PLeTBLURDyjAzjU=;
        b=NpgngvlK3nlmlDiIKyYUdjFLOKnAeUAia2HvrSGS6j9kJGUjR00sZdg2nAunKVjZY9
         K9D/w9CqF+xB6Sy2MAKG9wQF7Qd5gFfGbdQyqVImSWzp7Z1s44Nv1VXz6zyHpD4kS12n
         9bxQD5NkXLTjhuPB2L9iAnARIRbJ/P1v79iRo0XSr5KbWKc1bU8p7UHpFQA1lb4xxBA/
         JTuhTYQ+vPMzXOcSAg/PuDIfFH88z1EQnfZtGXk6YtpW0pIr2fZO1Wrv65HNlbMNaA9q
         zaz8+XgeAXVVTEWNKQeYlKM1vLl8Ukut3au3GWTeXXaEATKQjzCSKGJIHf32bY9GmIbV
         S9fQ==
X-Forwarded-Encrypted: i=1; AKwUvByNKWkHMGQiI9aVQtxedDVA759OToT7vyyt0pkHHAx7l7w229TNQk9F6x1fOGsY26RqzKE=@vger.kernel.org
X-Gm-Message-State: AFuF++n81WjskMp3kEvZ9wVG4odupTKjbn73/thdj1cCVuUZEbriEvW8
	BpwlKlBMGZPqLlu/XZpVUD/s4ZqyqoqNIlfllLTQK5HcEuyLXZ+LqoEytvnJC6JP/VV28GlrVgc
	sARAD1sSa2ONU7xMwgo6sb+lebA==
X-Received: from iobir24.prod.google.com ([2002:a05:6602:7158:b0:9c3:8b15:2c82])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6905:b0:4c3:a091:52f9 with SMTP id 5614622812f47-4f526747d3fmr385353b6e.2.1790889660625;
 Thu, 01 Oct 2026 14:21:00 -0700 (PDT)
Date: Thu,  1 Oct 2026 21:21:00 +0000
In-Reply-To: <56d86280-fcea-4d2d-b6b9-b47449f3408d@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924172928.2110956-21-coltonlewis@google.com> <56d86280-fcea-4d2d-b6b9-b47449f3408d@linaro.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001212100.2035442-1-coltonlewis@google.com>
Subject: Re: [PATCH v9 20/22] KVM: arm64: Add vCPU device attr to partition
 the PMU
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Zide Chen <zide.chen@intel.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, Sep 30, 2026 at 04:27:27PM +0100, James Clark wrote:
> > @@ -77,7 +80,9 @@ Parameters: in:imaan address of a u32 value (N)
> >   Returns:
> >   	 =======  ====================================================
> >   	 -EBUSY   PMUv3 already initialized, or a vCPU has already run
> > -	 -EINVAL  No PMUv3 explicitly selected, or value of N out of range
> > +	 -EINVAL  No PMUv3 explicitly selected, or value of N out of
> > +		  range (>= max_counters when partitioning is
> > +		  enabled)
>
> "No PMUv3 explicitly selected, or value of N > max_counters, or N >
> max_counters - 1 when partitioning is enabled".
>
> That might be clearer, otherwise it seems like max_counters being relevant
> to "out of range" only applies to when partitioning is enabled, not that
> it's max_counters all the time but one is -1.

Agreed, that reads much better. I will update it to your phrasing in
v10.

Thanks,
Colton
