Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27887515886
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862229; cv=none; b=I9ELiiPrUhIt9XXlMeh5+i1bMZXPKgheiGJjGB8MlSI5r/A2Exucnnrrk0DX5NY0YSdCDjnapKdytUfOBP/0o11kFbs0IS6zZs6WPmzepdZ9COK+1B+dSmW5pmxDO5HA0692ZirlRdRAnbpTNH/EvgmxMPwQfjbZ+y3JccZrSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862229; c=relaxed/simple;
	bh=k2tGWZBSq6m9m92JJesXcs78oXeXxRsuS4Ph2lEaE88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxdQmxJez8Jn6euaCyk09wlTRwa4IiITtPllIWfyV78nWdZu3VV1gf5gRlfyhO2Vl34ayQFaDyL262gTGEmQnFt9M7VmlwinSOm9Os80dtpetkajsNOOb1rdzOIVqZh6BYe2DmVi94KOEzWsK1F3EMImQK2i9vH7zMy4RC1219M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DqZEzPfD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DqZEzPfD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so12643795e9.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790862225; x=1791467025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9GzyFhoA2S7uios3Q3nexzUQFEC9iru05+QnoGlj3hE=;
        b=DqZEzPfD04fpWPGHpCTt0gkiU5RVPxaVWzIV6kshqTUIZAhsEGYJWau1rm4ilNcOVV
         kDYECMPqc808q+3S/wlpfy4Zonr5JdeArGZ64LeZuynhvgIMus4R4su8oGglj1Lm7Q/p
         xxx0t/Ds/HICjF5naZa3MhdYJ2tCIUveTXkT1kUktpAP7fDBee/DrFA6B2C1G9r2Jj2g
         5eYtQtWNQIU+buEp98MmqzloVUNOrJN0KKDuaFOJuhAIgLy4U+ZO06buaRmY3e9CuhFo
         Y0rBd+PaERYcDD4xyDCY8m85jdUwuLOCOlAI8xp9OxbIPPERM7P2dkthIqK0cpQLltUy
         omdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862225; x=1791467025;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GzyFhoA2S7uios3Q3nexzUQFEC9iru05+QnoGlj3hE=;
        b=azTuoI80n3VCfCP0U9ykrulvbAJ8y143B/aaHHGCBecrc6Dm53jWku8VMgeIq2knKc
         yKEtNtgX10HywGbhwiJmFjonSldr1A4JrAqiudpRsN4LKpsIcJt99mkqiiEow3VPg4oa
         Z7J+r4JnimrAZiHuyZ4ZMxp0qGjFULZiU0jwKzkIzyLNmRP8Vq4YI8DCCAlmc/Lpiwzd
         jvW6zwA4YeZO4g8EVktJoPlT8EPNTWCLvWTGoM1YHqyc9jZl6w0HT170CK5ukDaBfGbw
         cx1P4ydQKF0+BMivKpLmk4Rr64CS/ESPN17CFzLLG+NVQrekugxQhNlBMvw028molhuI
         sJIg==
X-Forwarded-Encrypted: i=1; AKwUvBzbSw/eMMxhfWWeuSJN1/CQ+c3dPdZCq6dPL0ukZV2wOOCdGiIzKRREgczp9Lh5c888wLk=@vger.kernel.org
X-Gm-Message-State: AFuF++n2ZBFff0XHMcT1LVx/VNA06+LkdrkIsrfBqFc/kHqfQwHGUJVS
	cwjrUaK8wDuU18KEVMcwj2whRtrE8NyhDjiqU0dRtpBHHUrQ/qU7DEPw4deM4h7ae/s=
X-Gm-Gg: AYBFou2Rhp+r3wBZySFo0l97Bl0XbWW2WL8sdfDzly81+dSkNQ4z4Pp6/PyBBLe/0bc
	uSGD2nYUXeHXgcvkzyjU+GVSA/+b4iLlra2PtQBIDEw36MgFkA1KTwhlX7CgcSBE3BPeWToJwig
	mXAf8qnU4SM0DvwGXWGwJNSRpJnWdXbOF9CW1/0jLpKYy0AqS3MoPuw8EwNAuWVcAjb9f+iFsGh
	QRR3qfmaxRFCCsiXlXnBFPirxKgAiC2jJI2PRxGRgJnaQ2mkARt6o9N7phSAGb116ErABaLlUrE
	YkmVk94fB48/evbzJBiOn4bCQCL65b4rKJ+BTnEQzhbWb7bf0frySM7n1gA2dh79oVuacQkilNy
	/EdLT0fethUOjZNn0WKitZD11Eq1AhyKA67H4tE2iFIzZxx8Paaf2ZXuExJl2omFb2aFvYb1CML
	YVsK5o2RT7HWzC6FFw11GAjDhTB05kJdDs/gm1v4/NKvc6bTiE93Pj/rdxtpcSQobbz5w=
X-Received: by 2002:a05:600c:4f52:b0:4a0:22d5:21af with SMTP id 5b1f17b1804b1-4a022d52255mr32632575e9.15.1790862225048;
        Thu, 01 Oct 2026 06:43:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::6:7dd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ecef86sm33062845e9.3.2026.10.01.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:43:44 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:43:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, vannapurve@google.com, erdemaktas@google.com, jxgao@google.com, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, tarunsahu@google.com, 
	pratyush@kernel.org, fuad.tabba@linux.dev, David Woodhouse <dwmw2@infradead.org>, 
	yan.y.zhao@intel.com, michael.roth@amd.com, suzuki.poulose@arm.com, 
	Christian Brauner <brauner@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>, aik@amd.com, 
	aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>, kernel-team@android.com, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 00/17] Allow guest_memfd to be created using a
 resource (pool) fd
Message-ID: <ar5iaaLcyz9dCXQI@gourry-fedora-PF4VCD3F>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>

On Fri, Sep 25, 2026 at 05:50:47PM -0700, Ackerley Tng wrote:
> + e.g. for tmpfs,
>     + Use mount page size.
>     + Respect mount size limits.
>     + Use guest_memfd mpol and fall back to mount mpol.
>         + Gregory, now you can set mpol upfront on a mount! [3])

I haven't had time to quite give this the read it deserves yet (have
been traveling this past week), but I think this mpol/mount issue can
be solved with a new dax driver (which maybe provides this provider
interface) without needing to involve numa policy at all.

Essentially

fd = open("/dev/cxl_dev", ...); /* backed by anondax driver */

then later when a fault on that fd happens, the driver provides an
anon-memory allocation that explicitly requests the node associated
with that device - as opposed to trying to jam this into mempolicy.

If you're planning to be at LPC, happy to discuss this in person, but I
think this provider pattern is likely much cleaner without mempolicy at
all if you can just make the provider do that allocation path for you.

~Gregory
