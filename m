Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CB33FE09
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103917; cv=none; b=IaiNKMhpayKMa4X1gpA9H0luIKpGj0u/KiK6I1jBTRfKeN5JKAqmZHfbluzSL3ruF7mmfopIj5hB/caaXLh72oBcjNkp8MOX+TM/61Xx1vUuvr6SFO7bfg+pLhzz2DozTjuHRp+4F9EwgdXuQiEnFEWHokuKLaz9zoubB5xHZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103917; c=relaxed/simple;
	bh=yKIOVeDMoyyKuNuuEbW4QRZPZ3f89Hrgi0Xf45glbnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGCVqDKNMHa0WnCLy8Aqvv2S5cTBF8yjrpHYwEzmGg4oYFvQ42crNX8wUJVqVejlcH34zZFjmRjHIsklpqqxMlmiMod0ueydoXwxuoXPXsSytGZ4xN3LMXNe1l8dThR7pjZLTphYLqlc3f010DwvB2uKMjqA4iCS6FknhdZ8a9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je0403aY; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je0403aY"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270fc2bdf2so38415c88.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776103915; x=1776708715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKIOVeDMoyyKuNuuEbW4QRZPZ3f89Hrgi0Xf45glbnE=;
        b=Je0403aYBMniQoJfV8ihvBOTd8oPQ4vtGndWU5oc4xI2rIwxfefAL7gPKSjLaXYDcW
         gbXnMgIS6cTq0cTAhTEVgFuNeY5qfBbi8MD3zymPIg2KVDWpi+jPXg8wMICDH+csrQXr
         P/7V5+y2bLyAI9XOoV3/8irRYi7VDCDZUj/QhPaMvhqd6MjasE87qPvAqdDv+Z7Seexh
         y9pbFiNzHPfwroM9Y2pAJ5jf41q+l3D2tLPGQ9XacCYkvcUicSD3jXjakdxuDVHyaHsq
         Quw0gcAVzjEz7yd5K9FYzJn5J5rdN0r/oMlsgb+swRJUiTzgA1+E2bxAe/Tvj+hWDIL0
         hAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103915; x=1776708715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKIOVeDMoyyKuNuuEbW4QRZPZ3f89Hrgi0Xf45glbnE=;
        b=DIyly8QiR5gqYc4OvmCo3um84Nmc+PVqy4hXPiwxNQIZVyUojbLldy7XJjWEB5cOsp
         uQWO9vn0g6tjXESCbJquPb4ImdxdKAJIoIaeyTo309S4WJtNL5to99VfUZ1qizmwIOTz
         zrPG9LG8u/fhJHcoGV+uKxIQYSiYzrUlPY5TXu6llQNXuIjXxU3pr4NoojtPX5kUQRm9
         AtKyizBHoLnG5sUFk7VGYHQ1hQ9sKCwp8Z2baWk5jnwrycwJECXb7uG4IQyPZ4drpiX9
         GSvYxIJHvva4FHawmvmlrQKL8H/RXTMbf8dtGraMEOsiObFnf2450bUa1dLNsG4sIGOd
         A0WA==
X-Forwarded-Encrypted: i=1; AFNElJ+omQqhSULjwHlpRR4+AmMBzwdNPGlXTvBNEnuMgF4Q42tGLlsH5huuWKi/XxOWL430EEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvGf6x3OEVYfE2/wmHxdwLcJnBY0jJSjzzcJnGzOgCJX+qXQ0
	E8qKBraXYCKnfFpsPgbL1lBznolDpVo3OAP7MLJDYFwMQwHhx/38CPWEaImf9OJegQ==
X-Gm-Gg: AeBDietTCphmWDhy2sbOM62np8jcABYQk5AzXaIuZLA0PSYscmV00PFo+N5p1QPzYcW
	7s3MtmmHzvtDDZ97cUqzdi4kpJxOLTC03hS2glF1ibkkVFyxvajtg1gdaHCrR4alukkRhP7phmX
	aGNDShPpCH+h4GTapX/MxBf2SlnWZkgLyO69kiSm4x086m8SW4Evvg3cTHP/K+PQ++A0Q5IPLDc
	NO8Q/OIALbsc36hjqyskcP0rlynr97KYo85AI+2WmH3VanmNoflGhFDMxBtYubvJo+o1BPL3XaQ
	9iqW9wUDxHEkOwfLtXJkCEYOD1liTlsafA3W2fDqcxl/ijtAib0TJ4X/KkoTIBatQpdrwbUWB5q
	VxAiQavs0GjB+jeumheKNT0VKBzefMiWZw3u34CjJcNXIf5zXSIOhpN6NK7+NHqvyDXIBOmAJXh
	dZuF0sGVEnxAhzUSJwt6UTBG/rpjDu96I7hl3cthwwp+7dTcuc09fAkheHUmsGkIdaK4/4ajKfl
	V+J0yx7
X-Received: by 2002:a05:701b:271b:b0:12c:32a7:1569 with SMTP id a92af1059eb24-12c32a7166fmr183088c88.0.1776103914619;
        Mon, 13 Apr 2026 11:11:54 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm14849143c88.15.2026.04.13.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:11:54 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:11:50 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <20260413180900.GB3034974.vipinsh@google.com>
References: <20260402173059.1018805-1-rananta@google.com>
 <20260402173059.1018805-9-rananta@google.com>
 <adQyhegJdEWuUIi4@google.com>
 <CAJHc60z3gPyGHbL+HuXrCc8OiGBKfAh1MX8rqYrjeaXrrmy7pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60z3gPyGHbL+HuXrCc8OiGBKfAh1MX8rqYrjeaXrrmy7pQ@mail.gmail.com>

On Tue, Apr 07, 2026 at 01:51:00PM -0700, Raghavendra Rao Ananta wrote:
> On Mon, Apr 6, 2026 at 3:24 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2026-04-02 05:30 PM, Raghavendra Rao Ananta wrote:
> >
> > > +/* clang-format off */
> > > +FIXTURE(vfio_pci_sriov_uapi_test) {};
> > > +/* clang-format on */
> > > +
> > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > +{
> > > +}
> > > +
> > > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > > +{
> > > +}
> >
> > Please do iommu_init() iommu_cleanup() here to reduce code duplication
> > and as an added bonus you can drop the clang-format comments above.
> >
> I think even Vipin suggested this. Last time I tried this, IIRC got a
> build error that 'variant' was inaccessible. But I guess I just had to
> re-org my code to make it work.
> I'll do this in v8.

Build error is because FIXTURE_VARIANT is coming after
FIXTURE_SETUP, if you move it before it should work.

