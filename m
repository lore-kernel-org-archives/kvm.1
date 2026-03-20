Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184D175A9F
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031266; cv=none; b=p4qrdSTF+R8tsBcFcMKhkDp5uJ15Fyy9gs+CJhH+I1K1AkBYD5SO/QtuYgGbYOuQPX/DompD9bJKP6287ZWL/+cV11Ioes3YElG4A//X7jgNf91aG7Ps/DIXWNxggP7gWQqcc4HpGa/D43RPZZA9m2w87jJhjobz0mCXkQa57WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031266; c=relaxed/simple;
	bh=rUJDpu/Tbsmr3Z96uyeTBTqVQmswY1ls9ES7BCAQFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk5FEjhed51Hq1kf/5pQkUMxWmP+TqvTlSRVbXUvEB86ODsc9zQV/vcTnax81sWXq8KfumsvWF16kLErXQdua8UDa7eiLYSYJWIj1o7rpvqZoItYQ7h+xbGlwSpiIBc1TvykM2yw0y3fbxCUkjfPHctFJv/+ys4AmtUGHo2bQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzUZxAhq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzUZxAhq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052562254so12845ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774031264; x=1774636064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8W5cvFUR4VXf+WaiJdKnvQRdmelG4HkMeFFekxFTBY=;
        b=JzUZxAhqDI3fkZtkuQtZfFs+pNKCrLLueoi4rGb1/yvavp4w73zp9BShpg2KQPE7uZ
         DMlcbsAMtDHQwZSFP52LlHJdPW2yy4lEKn/tdXKjk9hUq/PZhCMjo/EvLwee4l/1SC9+
         J+HoieW2lXF5pacpWawNWJ3XSHYAEBkUX/obqbO5oC5OPBVndKMPBI8WSDU8bDUVBIX2
         x9IfsPJDHGi/iAVyUxxF4gqAtwUJ/LrFi8wB3mHa2r5fV1+vvl1eCA+LSoTbyLHgpAQm
         Nvio0V2Pt6Ka5nW6N50ohd0yKWLBjFWLoIHzr8v+V+wXmIT2n9G7i4kIez3F9jzZwTcQ
         Pd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031264; x=1774636064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8W5cvFUR4VXf+WaiJdKnvQRdmelG4HkMeFFekxFTBY=;
        b=adeOo2P1J6aTcqOEqp9GmSW1JRB3vLNMEVzSFoNiEnL8m7QncCVVzrtMCq7MFGE/in
         wAc6L/0PWwUe0TfAE/l/fRV/DAolKrwaqSwKXwUPiKOu5Og6TosNlsPnZHss3gssXaO0
         WXIIOortOwESC0+V93Y1MMGng2GtYSJmHOG1zj0itPQ5zXoyJvFzuDD1U7erVAki6Ig/
         /Il9ijJ0f5PnbR2HQNsv0QprvZhkaeE3OZayWZJe0H8FebBFiGlFL/GaXQUZYGmES1Yy
         nuJX+LqQghAo9j9OyKqMy2bUjaA2T+kIRYnKr4lq8F9XR2ckAvaXr5koWzMUBAr78n6w
         jsyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxcLZFVqb34krAbE6MVO/F0sv5hUs5Xd1MasxzAEI3uz9yW4j1Q7sHn4cSOJezu4FzJ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKubpbvagVxy2AUDCL73cUNzOBP5i7q7susvfal/yneEO3MqS
	tnTnwhBgiUso5h2xumYEKXZq6menYTXChOF2t+gZ/tw5EWKBytZyiIxZyJvhjcmd6Q==
X-Gm-Gg: ATEYQzyJF7uTztTEGFYmMaPPS3zBj0CidMJXWSXpC+6NMmW8yRmzDW67JcD+YIYj94J
	1cOjchfDz9EILg6opkhucDi9h3suhxzPYxhgKVKtiY/K55piLAure3H1cjyTb6Xg+LhhUUuiMCI
	wWlRAV9jDcTtXQAFhAQuK+hJMEFxOQ//5C+2IjASBkJb7q4yb1iKuB4H0gtdEmidGea5IEl/vwN
	QUQOZ7yHvX6wex+0SyUUA4xADiD+BUwu2dVQHeB9w0YIue41Ld/lPww/k8j2dBiGIGkPMM3uYxP
	i3VeeEY3O3QJ5lKQEaDKA+C2oaUKoFNF67jC4J+qRsa21hEIIXPwHGd2HLAVKiVOESb2RT4VUOq
	BnGw1/8d/MLWSNqHcjLzrhiR3+o8aEWK3aQ98UILA1TYu241TD3RvhHCiTOYsIkg7CQfPNFxTh+
	pjs4rbHEl0oNHVqnsJ1K/r2COFhIfKxsDfUQkmEu0XFUrl9fwo4gW8BdnOaVevcw==
X-Received: by 2002:a17:902:f541:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b08b40ab79mr410815ad.6.1774031264003;
        Fri, 20 Mar 2026 11:27:44 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8176e7sm2212848a12.8.2026.03.20.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:27:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:27:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2Q_ZH_UIHk0Ne5@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
 <ab0TPFo2esHZ6RIb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab0TPFo2esHZ6RIb@google.com>

On Fri, Mar 20, 2026 at 09:28:28AM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
>> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > +
>> > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> > +{
>> > +	struct ioptdesc *iopt;
>> > +
>> > +	if (!count)
>> > +		return;
>> > +
>> > +	/* If less than zero then unpreserve all pages. */
>> > +	if (count < 0)
>> > +		count = 0;
>> > +
>> > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> > +		if (count > 0 && --count ==  0)
>> > +			break;
>> > +	}
>> > +}
>>
>> I see you are trying to have common function for error handling in
>> iommu_preserve_pages() down and unpreserving in the next patch with
>> overloaded meaning of count.
>>
>>  < 0 means unpreserve all of the pages
>>  = 0 means do nothing
>>  > 0 unpreserve these many pages.
>>
>> It seems non-intuitive to me and code also end up having multiple ifs. I
>> will recommend to just have this function go through all of the pages
>> without passing count argument. In iommu_preserve_pages() function down,
>> handle the error case with a "goto err" statement. If this is the way
>> things happen in iommu codebase feel free to ignore this suggestion.
>>
>
>+1 to this. The current version of overloaded count is counter-intuitive
>as it expects a back-handed API contract. Since we're using lists here,
>I'd recommend using the list_for_each_entry_continue_reverse() helper:

Agreed. I will use this approach in next revision.

Thanks,
Sami

>
>+void iommu_unpreserve_pages(struct iommu_pages_list *list)
>+{
>+	struct ioptdesc *iopt;
>+
>+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
>+		kho_unpreserve_folio(ioptdesc_folio(iopt));
>+}
>+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>+
>+int iommu_preserve_pages(struct iommu_pages_list *list)
>+{
>+	struct ioptdesc *iopt;
>+	int ret;
>+
>+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
>+		if (ret)
>+			goto err_rollback;
>+	}
>+	return 0;
>+
>+err_rollback:
>+	/* Rollback only the successfully preserved pages */
>+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
>+		kho_unpreserve_folio(ioptdesc_folio(iopt));
>+	return ret;
>+}
>
>[ ---- snip >8---- ]
>
>Thanks,
>Praan
