Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B38449990
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628573; cv=none; b=XlvGo5s+RGahdSfLLuns2sypCeWVH4UZHHiG9g/1xURjEqWtoELobaX/OwlK2vO0gpP803oW0fL1IqmWI1MGOyy/tOD2VFkDobWJ9LXF04EOs1pyWJ4No0fO/v8CKqUKxtQPmQ3sFMFy1O/D5goBa6KSdJt3YSGV1qyKOwG5DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628573; c=relaxed/simple;
	bh=z9z0CaIxEYdoizsKfbUG3oaleCnjEMZRsWcvsAMotp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc6FrQq+CKa8QfkVh4TZdcZl5wKQhKkKZA4zDojsDs84P1Jl8QPmRJB/o4OiMDibtG4yG6wa59dgLXguGe9adxYZaFeH7unpgZ6J+mzRdS+P4HpbrTRMgDJBuFVz+8xN8olAjATWzedq66pAWrfLxe+5BdAy02vckfvN4kawoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QjQPYIgc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjQPYIgc"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84592b55832so166372b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783628571; x=1784233371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=er2nd01K52fzoSCDKuPe6L+4tKyOrTAJPVN5CW28/d4=;
        b=QjQPYIgce3Ysq0P0cHy+6cP0pBoZOI44EBd7S8M3/3RxI2hUvI0dK1SMHMYJzya6vK
         P8NqcoFGHqTxIgHwuL6iRUPZi/oX4AkGc1V6KQKRdowZeT2ojoajCgVstDGFBNi9nQsC
         RddqZfASX5bB9/yV/jXdhb0XKqltjcwFyo5meMwYEdqZgNb5BKFH7eZs4ae0cT5AWlRk
         kv2a8MDY0PpF+FjIKIwa9OLq+Y9HpKhmzAqjE5LFcaBWEesWIg8HrQHWyni8vKiPdC8x
         1Vu65xVhOZqoqPnXZhdTzGVa2YH2oqmcws7mXaf5LVARYRRl42QFYb6/iJb8VpE/O6pD
         f5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628571; x=1784233371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=er2nd01K52fzoSCDKuPe6L+4tKyOrTAJPVN5CW28/d4=;
        b=VijwufXsq5dAReO0iekU82YpJLg02hABtidQctMUjgxFnkR7twDR0e5lswlYqKmvXc
         ZqFYEnTdXLEwsZWl9jxYY3VknFy0B+1JOTeiHcYdWWGKReCkOew0Ytre3QHLb8PWITCh
         FPa735WHIjMgCF7TT1yBvZYNShVNL7LUa9WfCebUilEBwDie7xiq3i/zlqfEmDsQHrJv
         eMdNsnGasW1xyzOBJ8cQ0PqD+w17IoqhsJj8cxSenCwGo5zM+DtHnfyAK1qtATXvA00+
         OlP6RGDIX6U7p2RUzuXnCnXVc1Vap4l3/0oOIqch1R8qNVNNADT9hnwugUqUew0d3JTz
         eEZw==
X-Forwarded-Encrypted: i=1; AHgh+RpiSD0VN4GHyKEcii2tZ8qBKySWy+l1R4TsyuE5UhxlMWk/i6eo4MiBF184Wd9PKtLR3EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxiKP+A+tUFpWD62FVY9PpMnQSChBi9n+spFBYWsb18fO82dY7
	zRrYZlIq9ZOYexLO4UXvdg5+5TSpzpzWvJqZSzgpxHR3sGKbUFbqxhKXQwoM3dOXXg0=
X-Gm-Gg: AfdE7cnfBUhljCn65R0IfrLc0H0wZuh1LBuhc2A1FDLNvYnaY1XPjNW/tA56Wn+jnRK
	Qdig4fFI2vln+vLdDxXVz/0WSENfpMRVMfRPIRr/AVXs4eJprDsU+vYDfxx8hZcuxdrX/3dQofY
	YD7c67v/cbkguzd0Bi3S0wzgN/ZROjgsQ4Scms5h4aDHd0/MkaweVSrkW2vU9XFXKzJ8HMljnZq
	ZEKFT20ymOl0VK4VP4kK3POp3qjRYveuspnafNGPEFEORzvzrsxiqnRosAxbIuDXrHSeLF/xYzn
	vni2dKyHxI6sgFzf83I0XupZol3i4Bf8KRe1NuNZkDvUSezuQAFFPH9H96zyEd309DWBA5Xx55x
	VPy84UJMFrsLqzWIxTRcokvfXRL/1tbb8Ll7LhB6mAa/kWzTSo7WrnvqnlY+T1zFdJv//lwU63/
	cLQsoyQnD/GD2NwV1r
X-Received: by 2002:a05:6a00:91d6:b0:848:44ae:47c1 with SMTP id d2e1a72fcca58-84844ae87b9mr7146613b3a.78.1783628571139;
        Thu, 09 Jul 2026 13:22:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2f15:8249:27c4:1b26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4dbdesm9126916b3a.31.2026.07.09.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:22:50 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:22:47 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 03/25] target/arm: Add confidential guest support
Message-ID: <alADF-nLnPH53uWO@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-4-mathieu.poirier@linaro.org>
 <87bjcim6x1.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjcim6x1.fsf@pond.sub.org>

On Wed, Jul 08, 2026 at 06:39:22AM +0200, Markus Armbruster wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >
> > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > support the Arm Realm Management Extension (RME). It is instantiated by
> > passing on the command-line:
> >
> >   -M virt,confidential-guest-support=<id>
> >   -object rme-guest,id=<id>[,options...]
> >
> > This is only the skeleton. Support will be added in following patches.
> 
> Which of the patches add options?

Good catch - options have been removed because they are not supported on the V14
kernel.

> 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
