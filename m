Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE23356A0D
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788760; cv=none; b=uIl2r6sUwj0L6zcwo9ASuwKuFq3NwtIUkDS82zrXGB4FodXd4PBmi8EYX+Ml5HKtWX8lAM4bU2Q7kQMzL6F1B9HdTw3tom8yZAMV+gwGALz+lO3UDdJrZOPrQ4WNKAhZQf93YlAGAeIzLVxSVzWQoA5y1HnUXjs2GT29Y/OXO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788760; c=relaxed/simple;
	bh=ZYFZixZOPs2wnUXFfo2fKzeNQImuiBllWcqh+tEw9GU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D4xoNq74XR6Pf+HVd7UPLQ2uVzpEkSv1JOw/xGSXFyv+f6fZffCPxs1tx4635ojQYBCs9TZsjh4VcgffW57fLxZpvMlSo8eJY66qBiGh6lNXAezByn+GRd9FVy+YqGdjt+34VPJLQM7+kD8oMltqiKAx6jC//4kB+EWu915ynhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UM+gxFh6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UM+gxFh6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a2c90e383so79157b3a.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788758; x=1785393558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r46MXPNPzCsTmVT3q7BLWnTz4bE7Z62X/8s/DZiQF8k=;
        b=UM+gxFh63+qlL/DMHQbm/WHA9DV5EmiH9yDfiZtP5tRJ0FROQ5lcuI1mzrw2xjDH3A
         qgtbTQsXxeBHeGIpN8GJR1TSSmaOtaELr+8bQEN3s5nPuB1JhHDspmzQClPDLUkkTKLa
         742JJ4u0DHvhJeUVQ/dXrnO3Kav+9lr+W6fqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788758; x=1785393558;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r46MXPNPzCsTmVT3q7BLWnTz4bE7Z62X/8s/DZiQF8k=;
        b=sqHbnlCJhPHnyOVRhZnKAUIdMvun+ziNAoRcDGZl+uaL6bZyMx5oE+gINuzrwA0dwO
         y0zXFZO4BRX7aUyl2TqWXltws0wdIy7deh4emQIE3R8Xf36eyC0gl707nDZpFM1AYIVR
         ZitdanpcEi5kY4PtH4OCHKK1OEhQ1ei3ViRxSRLfvgvOeLbGnqlHIgsZs9h4QlpUyvPN
         +ml/HAicQStHMpikP/gIF/KybrvlLNLbbo2/6QbNX+m+6/ho2d/2n2cW3g5Qy0rnN2At
         r78Fi0ch8mmuC17xoxonWS9aDEeLOQM2xj07VYca4bb/ixbz31wbHyNpPP/Jgb1g+bHU
         H/CA==
X-Forwarded-Encrypted: i=1; AHgh+RrxXcb643H776A0/k8BTPPWwrI1gsdKzld8Hs2XZa8MIR+OoGk2Mk6IL59n0oPJFGnwREQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bFyDDUI82kEWK2tphTmZv8+eJNAS7dDHFSvAVWt0Ip7kNpT3
	vah2gz0vpk+an6SkYW0v+juwTsE5fqdL602PUSF9VaASAzOE++9ACUUvYYSGgEPz6w==
X-Gm-Gg: AR+sD13l4oLGPZhBtfERfbFSlnjr9PojPZOq8QnsIzHqQLeETYOxEzk4QPxIYHC/eV7
	JGsEL9b+7vnV7+KOFGL4uWfdL7f+7tBGnKqIDOuAG26KM/8mVJdS4L+N3Zz9sKb9X6gfMPAj7KB
	Ty2NL7t9Gdi9dG/d2r/A/pYSa/NKAzHIpbzfOy8Mj5kqsom5OqDrCYr1sDGvQUmFev1rGLp0TzX
	YKmHv5dsAlZnL4owZ6zU9Cl2q4s55HgwKlLgKNjP+iBF52dDqntGCt6arjtr9MfQaiN/Whf6X4T
	aXEmvlnjEiRt3K3IhUKlhcvp6302dFid6ZAxmkzp5a9nRotcjACZ0oe9ssGzsP8iKN4sFD4p2yz
	/0Dbhs7TwAJK9xEgBpVEG7+5ysrlXZVKHgaCZQ1oaxnhgN3uOpaykx02atOO/5m8yS/Ya51OjIm
	kyoJ8eKaDsWOrEjJ/uyxvbF9HyAN5jZgUc8LRxtI9MYA==
X-Received: by 2002:a05:6a00:e13:b0:845:eb00:ecbd with SMTP id d2e1a72fcca58-84e2e92a730mr1546905b3a.21.1784788758183;
        Wed, 22 Jul 2026 23:39:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175d4133sm2478570b3a.50.2026.07.22.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:39:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:39:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG2jCgWugrVroyZ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>

On (26/07/23 15:36), Sergey Senozhatsky wrote:
> > Sasha, Greg,
> > 
> > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > simple upstream but only due to years of refactoring and cleaning up
> > of the code; fixing from scratch is not really feasible so start by
> > applying the patches that are needed.
> > 
> > Please apply this instead of v1, due to a missing line in the last
> > patch.  Sorry about that.
> 
> Sorry for the noise, has this series stuck?

Sorry, forgot to set proper In-Reply-To [1]

https://lore.kernel.org/stable/20260626174620.1819772-1-pbonzini@redhat.com/
