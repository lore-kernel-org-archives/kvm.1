Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D6386441
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326294; cv=none; b=RH6KYKhGC/59+nPeWoF3TVNaeBEZ8tXBJesPIIf+derxhcOVo7hIjWs1JJBdB00TrEcOszAC8HuM4jM2RzbJXiK5zXsrcMxCWT7pvXL0BHKXxKy0w/bRcCVIDdrF8pgbCKhpYSe5wNT9ihwIWpwJiTjnQ5dUCvvDh+mqczHzBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326294; c=relaxed/simple;
	bh=FyPB63wt21dCSlA1V93ZxwKVM5EVA3FyVToqQROiiGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGShw7v8J/L1wP5Mvs/Ng1ZCBspLjb7g3chG6oXALk9nRSe3czq3j8WAvUeD+22Qzo72HeWY53//Yju1ujLpIYi/jhVQiu2OnKbfhMkqVMdr9mKrN/9hTDtG3VPBnHitGT1bSaM+xrVZLQ2n0z7ywLKsqwf5Y+CQpHkCPkPdJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2YEQYcP; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2YEQYcP"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d9916deb14so18944507eec.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777326292; x=1777931092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks2Lt6yJ3ah4mtlHpB3bqT5HUFjdEUDMpMI/GdsyYSI=;
        b=F2YEQYcP23c0Iyv3keFB9bgOzIwkA6udEuGOubXwKoYWFfFQBYuev+KEVlOsTsTX2A
         TJ0u6A1RG/sVFfzHgbn4ht9c8h6FcBMCZZYpYzLAk1t1R/rshQ7+XVwFk0hio7dPrXya
         1Np0QYx41dFEwoiHPgcFnR7qRxh+DVXKWmXb/JbpqK+5uX7d/JT369djstqVj5yWEcxV
         kCzzMQaQQURnLG9h4Vq1gzuTNRPqCJ15CyJYL1DQ2oTD5pIRATx6vA6Zt/mdK9tbxg09
         sivAf71/Vsywyu9onfsJHhQhgqiEK/+rbNDibpsIKAY70hLEkYS8UndoWWEMAlUvqAoX
         NaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326292; x=1777931092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks2Lt6yJ3ah4mtlHpB3bqT5HUFjdEUDMpMI/GdsyYSI=;
        b=kN7nY80K8/MaAMv9IHOG4Qni9PF4sZ4zFFLfD8ksBgKaViIfJamKuOzGHlNbYTVoDG
         j5oy7ScwFf1lKJSxzoMarAiEnSWDw7NmxfWgiVFNG11DqBjWE7nsrtZKWDY3Ub/RAAIZ
         Fbo+DP0eYqbmnz0Hf+oCgJpaR9FTsNgClh4RS/HxuH9m2VP0r82VrkfwC4/YjeM6DDzn
         fq4YzqWpNW2jfXK3w2yvbdiwwhrnl/JQ/MV9EgqXfX6u4EXAikg8UewLnbLjahYFnCUA
         pbp3iBgicibDQTQ1xlbcgGGACf/htyveG1WsD5Zkp1KXWMTHdrbMasmCblcMpYE1kJgq
         B1lA==
X-Forwarded-Encrypted: i=1; AFNElJ9RjJd81+RF9O0jBfco/QODzPJPuJfkVS1HdccCHrM+DJqy2VfULZmTetq2Ow/PMp6lcC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2g/zugH6s/3T8ow6UveY1nh+fKxuROXoB/pbaPuHScxQUAlKS
	zDElDhZ9qVku+jRn6GikvwoL71WlvsWiI9xwJqhMgkfm9waVdL50rI+X
X-Gm-Gg: AeBDievb3vJ6lbMsfbstnXe7Gjs9PuZ3rbjCubT0ieXKwLRqjiRQMsk8rn/YO33mysI
	+pPw82ki5wOxc6wassgI+YifJo+BO6KiwQCitH9wf5bho/QftYBBWlZ1+yiIZpP8XOOWI0eRTb4
	MLmpVaevvpLGQGkRd7pHTMy2YbRbWWBni55AWmhssE7ZsBvC5dbPOpUtfZ/NuconLinNa3NnJrH
	lUk3oWZQl+yvl8DZDjO05FwezWDRx3Bmt5xq3/2oIRWP6hA1zAWAjkaR99i/EIE0W67IoKA62BY
	SC9LOeacZTIJxgN7XIp+2a7zxx0hHn0BTrq7HdYwQSnXXYMvNqlsBc+2/u4HG81hExL9VVwaeQp
	mvacOht8uV0ovpmAoDmSZerMouGqHf26D4/kd0pEU29vx6YdUrnCUj0Fo3nP6S7kHchISf0LqIi
	Cl+1WuXwVXqoI5qKofot5Rdw3e09/8GLMZPSe6dXP3J02AprE=
X-Received: by 2002:a05:7301:128d:b0:2e6:4d6e:2cbd with SMTP id 5a478bee46e88-2ed0a03bbbdmr354798eec.8.1777326292467;
        Mon, 27 Apr 2026 14:44:52 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90::47b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a13f915sm649354eec.31.2026.04.27.14.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:44:51 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:44:49 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-m68k@lists.linux-m68k.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mm_types: remove references to s390 gmap
Message-ID: <ae_Y0V8WsHPfQSJk@fedora>
References: <20260427105810.23761-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427105810.23761-1-pbonzini@redhat.com>

On Mon, Apr 27, 2026 at 12:58:10PM +0200, Paolo Bonzini wrote:
> s390 does not anymore use special struct page for its shadow page tables.
> The honor of giving a special meaning to pt_index is now m68k's, so
> rename the fields and adjust them for the desired type.
> 
> Cc: linux-mm@kvack.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Acked-by: Vishal Moola <vishal.moola@gmail.com>
