Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15833B94A
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861667; cv=none; b=IRmsNvyDiejwA4xRox69/UfGo7T1dJX2uC0tJuxnwGT9UuqIhXpEx3DFx7O0/cEER/Vy8CU24B+Pjzc1od5lUL8krjOps8FMTVxkm9/aC9oenR4rDsAdjjA4eR5M9vHwjZqWOfiWF/N4t7VsHXOW/S0l0dRJ7cF3337KA9qBjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861667; c=relaxed/simple;
	bh=DOE7GK57vZlKqcHv0u1F5+0CH9IVtCHv3OqzssKPRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJR3QJf6axlJp2zgJzd76GTg6zBRgle3fMrgyWjcRiu9Odaq1yQnMq5dL3PSaiknhoK303h06Z7hqAPy04C7UU82sPuguVWcCLH+ZX8WPby6Fbvty5pYhOUOT2tgNRW2QNL5omhBzWGneK2evTz82n3vrkyYsev08flM14uvXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S15/Jzfq; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S15/Jzfq"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2272605eec.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775861666; x=1776466466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOE7GK57vZlKqcHv0u1F5+0CH9IVtCHv3OqzssKPRD8=;
        b=S15/Jzfq2XV2hWS5QMyJBxUrXeNffFj4/gJMthYpjgE7lrMV8yEUIK3uX4Oz94bK3/
         l9i7NMTqTil9kf2gxEKrit7nJFXQO778ySq5NBsHRI7rU9L27+rei1AtswdRfN27qSDg
         xX6/d9OimAwgx/ZylvZC4UjM2oPKMrcH0EZTAtJ3VLYwm4JVl668p/3aBcpMr1P9j1mz
         Ba0Xs1rDBZh1driyyh5dzSMdShmBf06fNnyPyoGHm9JuhSOZMndU4JvXWDy9svtFogWJ
         /JIJIFYhrv+un7WpYsNvJ/ZZ1F1dEJ3Z28ktzdr+zSEpU2nFQZFBsZB1Z1ltfKMedS9s
         aI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861666; x=1776466466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOE7GK57vZlKqcHv0u1F5+0CH9IVtCHv3OqzssKPRD8=;
        b=cRacEJwiOnPbS5kpotve3VwoLOW+R4QIX+o6nP1LPHgej+ajiRv6UX4Scg3p5U/Rgb
         49KFx/x5Fxp0RC8bwYvhJrSfyn8MxfnstZWMoroVbywjqQQa5knDATqSeoeJeZBMI5ZK
         Lc1NjD4dSfr2seRQthvcyiDVgNIlRYV+k/Z4NbdOq8bbownVnsupCYhmtiL0s9tPg2px
         DJgXQBsfszxQ0MA/kLXLH45zZlePtUlwJIQfF5hiHd+rAwKLmb6VarjjiXda8VHzW6oc
         wbGTK1AZGqJZqYM6h1W3Yn4LT9gv6VaYO+eKA2j/aD0gwb1hRRbUbkTKIHm4AVxdPdFf
         BqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBC7n50Efjy0eMzcmjhQQcL6DWju/AOedvt3RagqoSWlMzALNy7jCOMbUkIRyD3HlD0aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CmHTbvT+s/iYH39HU95POAS5Ordv//kBIyDRn4PZemblt2qN
	CfYaxiH8vYzfkTAmaC0W8uUgqljOQ4Sh2KJOxwKIe/lZ1gJ6nW2BH5kem0fTZRHC3g==
X-Gm-Gg: AeBDievGKMp3GYXuRRJ8mIuzSW/Sh3R6vnnFMD8U82PaghLMBZM0/6xDIGdSZPvYiAg
	keP4bCyBTp3nIHZjEccsGTzYFuQcedws9/rnDaKCHM8Xr5UvBqXyMhvJJdd9cmoa7kT6uDMV4FH
	4uNKLLoXX6MCOPbm7eqw1tPjOWYIGrvmCcbqisWCESq8c7w51yfEK+aB/VKjFk5mmI8vRSqersk
	T0CS9NwBp2Q7A98ZlQ3jwC+KX3oCA+le6vjP4vCvPNt+A12qqUexpwQRDRLdQ3FpW2caOe3bHkn
	/TVUonYfTV3VmlQDiZo6Iuhl7mNjaRJfMLpJPN0W3h2nuUoxfZXu7n/nChBYA8/eP4mkFIF3lOC
	OPHzvnbmyClyrgtah42hLTDHqODVlUHoZmnajsdfBae3y0j5ASwBfRJ1gnFnLMW4sCINid099ZZ
	Up9w0w+xy4IvJy44B0R4vLthMgP36SiIMK05r7TTH6vx8DFIJbBIj+sw4rUI5NIh9mD2w=
X-Received: by 2002:a05:7300:8609:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-2d5894628d1mr3153184eec.20.1775861665280;
        Fri, 10 Apr 2026 15:54:25 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ff826dcsm6161955eec.13.2026.04.10.15.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:54:24 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:54:20 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio: selftests: Automate setting up devices for
 testing
Message-ID: <adl_nGI5IEc815fb@google.com>
References: <20260409015139.2800185-1-jrhilke@google.com>
 <20260409015139.2800185-3-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409015139.2800185-3-jrhilke@google.com>

On 2026-04-09 01:51 AM, Josh Hilke wrote:
> Update the VFIO selftest setup script to find a device that has a VFIO selftest
> driver on the system, and set it up (i.e unbind that device from its driver, and
> then bind that device to VFIO).

I am leaning toward putting this behind an explicit flag (maybe -p for
pick_device or -a for automatic device setup?) that way we are sure the
user is ok with letting the script start messing with devices on their
system.
