Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714478;
	b=o/FACOykaMt/2y4lYUBMwmuzpbRXfk9k89yJ7EgWlRR0hHJO8wm60tnZj7oEmYfUENaN
	 WeKGz0ME9OvjrWWxKhHyXYywUVLh1MZmzlVrcVerdzduWUfXINeVCGGy/DRnT81ID1ut3
	 bmzVXm8mRZfSwAJZvaYVEpuz3nR6szXJkuXDPJJqAJC0HfTaKTH2jQhjDE5tWnNup05ir
	 VrLmlZETRqON6HYfSk6tAYNOT6o9JiWmvLwemhdgDFPHmjDDIySml3x/9N+FbGQFGvZLT
	 ViYVuBNIusNi6hMqZ5r/974Zu/WjXg6VDdWYjM9JQvBeaN1LLPgScJqihBA9aGMagTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
	b=MNTAvrTjPr+FR7ERqKfyNttJXgNhdSI1hxtgJTLCE+nGa3iAjWJH5/xzDKZ0yF0PxRgc
	 2VDGoY0hgGRJGAo7CMw3NLpKZUod4wj+nvG9gqHb2Vdho6qxzBcJFyR6QVNEx2W9GUR6c
	 l2CFzUupM0ZuNXruBZAL7bZcZlkNDaoWy1fhD1QEAHCUBdKG/vpNPkqbazLvRcfnaSBBX
	 FVeV/eTQC982lnXeiqJAhCOdXfGVxj+3FrNj5AVBuNXB232b47+Mm5/wvLKwcntVyh7Gt
	 6GqeQzn6YVDRbzgUkx3WwKqjo9bHfbpw3jHs/Bb5KkoDT5IxO3vXrT2xT9eU7i+wavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgVNgG1C;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB9606A323
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 03:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCB9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgVNgG1C
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37600b0db49so2996654eec.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714477; x=1795319277; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
        b=bgVNgG1C6rEiA2UQNHoL5Gj/SiX2TxSTbtiLXx/Q/+sOZONE2Zp5iwCs8HXLIpZ0Ih
         W0AagTMkdB91z5RaXhz+yDrPd7XPmtx3xE1QUsl0KVZNBHb1DmRdxzqinXPvDSpGHVe/
         kR4gHm+jS8YEnw7iRWsouWh2te9N4b3sefH7wA2cRuapkltSCgKlgOTQoomLTGMKa9og
         Y51wCnWPFFapRpzwQAh5yPIUUfEyw4VRAFFIJ+QZP+WljqLWHMgt1Sske+OQfzcVHvj5
         6vdBcd/B/vIFyFakB6dfbAcbWXM1VpLck7NjLqTk1rxuCMjsvDOi2KkxXNWWeaU53EBJ
         XnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714477; x=1795319277;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjmFqyVwuBvTU6cvsaTkZ3oz9EU+ZEVRCv7g4CuSLzE=;
        b=cb8hXWFx3oAXns/Xjnw5CqiqElLkBhVSKHFtYzXQpRgafWoObH1sEqQ1J4sNyDAkbt
         9rCTsiZ5h0UvornDKukX5Uv3bmepPjmgg3WMGNr+X21AkQkXPr2hOgjkyeyjZ0xcB8G9
         ES2aCdmgsCi3V8rWS2kKVosl3/WP+OYv8YJmGzufxtQAJcIY/mEgH7LH6WeeDu+cR+6H
         /q5T0p9BZSZIYKCWhLE6Ji1MMFht9vcOvR7nG3UrmB7zmtaTOGpLHUREmSIV12U20ogi
         6GAseAQIcgAd0duCUn37lcw4wjSRGapQSvbVtb02bFYCxuIe68bX5yFASaPMgzlZhygE
         xsaw==
X-Forwarded-Encrypted: i=1; AL+hErG7BAF8IQhHqKwXF4M8FWstZogyu1dHQyY4XqrNB5Tcj8YxE316TuWbiuZGqm6PEkMOJEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ioKncVR8mKyzkYs/cXUZDSKDE5C7eWVeS7aEKP7DZByQg6uJO
	n6hrXPJ8kVNVCn2R2J8btVqBLt0iKT52l/8cU68Oe5rhqZXNVCKXy7IQ
X-Gm-Gg: AYBFou2gQ0ZfO4oQwvVqCrMmEMrLwDEZwrRNPt9zH68DW/1s25t+tJEMyh9X0hgaRUy
	Zv/LRhuCtdKcxrNgS2K7Nx14JILeHnug9xKT7pm1Q3TKJzw4QyrF2Rs6ANvR/MpODdCpUoiI1MY
	0V8Lc+AIT/QwBfRkUzBtilQVuV6MbWkGWJQoxSWcJXZ3pUvCZt3tiojKW7DxrfmHQFB13LYzm4L
	vQreDKRcjCN5ccn+yRRP+nuybgleYc3IC6BiQd16Ls9IkXRaN8BN/ml5gZw+98JtbN4aEKjb4v+
	GuKVBWZm4xA1gszwidfLyIqn9JQ/TP6kK7L/kgAUVRlj9AvH2kln+46npzsIjzqfJxjtgc+z459
	YdnomKSZ7uV6Yy+dlHwUtX101G/fKdQ1QeCR73EYAPag+/kQEuNY1aEY4/emErcKzWCn5aMOnzr
	pzyK6W9NQcQveYIJujZbwfZ2pkElF9pxONeVGbJWXZdGK1o8fbAWVRmhbxl4WQ3k0m9QnPbQ3Vr
	T8pmCxxIGFJrRtEkEYgeuDU4hZlp9IUeciXoAIubMDMQ++SQM7h00KQMCbELd3ZSTLBcIHZLFZd
	tkL0VS5u5A2Pf5RgGTgPLolXTq4=
X-Received: by 2002:a05:7022:1407:b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1b4f5f92e6bmr9170170c88.27.1794714477032;
        Sat, 14 Nov 2026 19:47:57 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm19896393c88.12.2026.11.14.19.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 19:47:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Yadav <yadavgaurav386@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Yadav <yadavgaurav386@gmail.com>
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
In-Reply-To: <20260807084050.25216-1-yadavgaurav386@gmail.com>
Date: Sun, 15 Nov 2026 09:12:47 +0530
Message-ID: <a4na92vc.ritesh.list@gmail.com>
References: <20260807084050.25216-1-yadavgaurav386@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Gaurav Yadav <yadavgaurav386@gmail.com> writes:

> Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> and remove the corresponding TODO comment.
>
> Using vcpu_err() provides vCPU-aware logging context, making it easier
> to associate register dumps with specific vCPU instances in logs.
>
> Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
> ---
>  arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Fair enough, this will print vcpu_id as an additional info here.
Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

