Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A026980F
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877596; cv=none; b=DWubTPBIzP+M6N//g4/Zcl9iYYezVfhCF/I8jFh0fX8BLQTJWzwBYhSI17MBNXBd5cZ0+MmTCW/lwjoiWnS5yeGA1Kfng970NZ/M4iJ9vb6yqZdDoPh1yiDoForolMoqywvz5iZmsx4CwDImRv3T+ZWiLWKBVO/oWMIigjD/BRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877596; c=relaxed/simple;
	bh=PtzNi5jL6dRXnIJxLZwqNq9cHEjuY4iH46hG4A1PvaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyZEUtH6Tj92KCYBbS6rb2GdkJp17f/88VtdPiMF6u0KaN/6dNm5xKvN4x3CNZH1t5pRnyQg9QkgDVNhY6iIgMVhk6Gq7uqaWRgv/UHkTrvifHZ1bAdMKONnhv2tLkuLhbalMzYG03RXf4VAG0QBSEJdJzyYG9ffw/+a6/3ebR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3DHvPdK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxU3skdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3DHvPdK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxU3skdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777877594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kl86EyoPu9SHMk0byoBoH2cddEevzi3KGgfUVzYWT7w=;
	b=U3DHvPdKfgb4nA1eG2rgzmxrbivs2LVvIW39h9/SVypcu8CM2fRW0UZO72BnhDKNzygPgR
	a6TV7a6TG2vQVx6qKZtwhzx2t5TNIAUDrsHGYeXPJKmNRzutFGcn9VBxflD8tVoDW1VhNc
	DlsSAf/svTZd8sP/f/2QjyJZ4a7tOpk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-OjYckAryPZCLwLvPc25MYQ-1; Mon, 04 May 2026 02:53:13 -0400
X-MC-Unique: OjYckAryPZCLwLvPc25MYQ-1
X-Mimecast-MFC-AGG-ID: OjYckAryPZCLwLvPc25MYQ_1777877592
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so22403745e9.2
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777877592; x=1778482392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl86EyoPu9SHMk0byoBoH2cddEevzi3KGgfUVzYWT7w=;
        b=LxU3skdTq7LaPQsP9IvMibjLWIqIzmAg56TpmeqpoMvyrwDGpRA5CZ6jv4l5AIhKuB
         xCgYKsKmI4CfsCqF6adc/Q5RMoAbk4t3w3L+jHxNo4G6IiKTGIO0MTq1slB0qAXEDPIc
         cX+t0VHkitGGEgZvn9uG43c7805ktoBEBgebzUgENqfwFAZUof3tDUPG03qy3dxp9v82
         E+l8RV/a/Q4qloVCfOFifMLKxUdiBGkE78E4mYk+SxEqTAxEYh5cSBiWJ10O2m1bpKmb
         mvxu2IqigitnKiFGWIjW6CqidCWms3Y6uspn69DVSE6VO2rjVwDCAAUTl0qpKnZ/0mlc
         hX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877592; x=1778482392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl86EyoPu9SHMk0byoBoH2cddEevzi3KGgfUVzYWT7w=;
        b=eRaBUj9dvNCZFlEvj2CXhYElxS5bpeLTp22qWXfBre4lBmPquAXgxaZsWiJ6Xh/2I6
         ycJfxQSbN2guN1VXu8QvzKqjtlhQUI0wG1cDPJSNzNKvBJg6TjzXSRlR2n4CrZU9E9IG
         Kbz43Vyx5B0Fn9OFaCMWTNnKqOJzLnB9+z3cyC5apOrSaUoIoiUJUwRc4Uk0ySjqBEbo
         7WKDG7Qfz1QLaM+9lZXKSfFGWQ2d0YgUuQvZ94pfdwZWVpN+BFkFhcFyf6UJ9cAejJ/P
         pCuN9qVJySEBwRyyTlR6+5XMlnK90gnwhPNmLCVsrXtmEhMyDENmimIVQSW99VXXTCE7
         e1rg==
X-Forwarded-Encrypted: i=1; AFNElJ+YlbGD4SVJ5f27v8oGlD8zC5Nzr6nSOdLpreHaHU+ayl49KaV37d0i4bUPJ2SkOiHjuqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbtayifz21RnKKqZFnfMdmpszO+FIXmQf/qQlq1sdv2+7+gB4v
	rblPLCUvXDYPf4svF0CjMmJllZp+yc9f8uqOkMISbYwqjj/9KzyVB7dumVt/O55LTwqVbzUdEkK
	WMTKVRO1DuIoXLKcDnu57h1IFWBmLljwrRpMAMVaSmyAM7XLBimns+Q==
X-Gm-Gg: AeBDievGX+vyVng/Frgxzqy2ISBN51fgTI6fxkOsHnGAyHP/3m+uwJWT1WS1Axx+5cO
	9/f3jJji733bSUSa1/DyPogZzF9CGQxTJl4fBKXqLt3m2EL2jTEZEEdk+ZyTsp3DACLEuhjToYM
	7DQ+Zp6at7AvyKzu25uWIh9/NTh/pvci/shdZX91Bud1GBS2XlKXbMl5UyixWoHnEm4o2P/KWfv
	SpgMBNB1T2FWblYSyofI10Z2cdd98OuijmqMdXQKZYWiiI9PDEK/YcxiPKxPpeigQEb69ggI9qd
	TH0hFMcwrP5A9YbqEyx5Fb7uCFOk2LeFvfthSwEFWSKtUrfaCM1/YkWSx73bbnoXJAaXp5ZpbOy
	i7t3s4/oX4XnM3GzMlli7h0thlewPcA==
X-Received: by 2002:a05:600c:c0c5:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48a9865e95bmr100983955e9.16.1777877591822;
        Sun, 03 May 2026 23:53:11 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48a9865e95bmr100983735e9.16.1777877591451;
        Sun, 03 May 2026 23:53:11 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2f32sm250068725e9.13.2026.05.03.23.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 23:53:10 -0700 (PDT)
Message-ID: <b1f238d2-7547-4b4a-b716-565372025311@redhat.com>
Date: Mon, 4 May 2026 08:53:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 3/4] scripts/get_maintainer.pl: Ignore
 --nogit-chief-penguins option
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
 <20260427-b4-cmdline-v2-3-0fea2a50a9d0@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260427-b4-cmdline-v2-3-0fea2a50a9d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 19.36, Christoph Schlameuss wrote:
> b4 by default calls the get_maintainer.pl script with the
> '--nogit-chief-penguins' option letting the 'b4 prep --auto-to-cc' fail.
> 
> Adding parsing of that option without any related functionality to allow
> simple usage of b4 in the development workflow.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> 
> ---
> 
> Sorry, I am not too versed with perl, so if there are better ways to fix
> this please comment.
> ---
>   scripts/get_maintainer.pl | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 117b69145f0e..4d4ff4236f2f 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -31,6 +31,7 @@ my $email_fixes = 1;
>   my $email_list = 1;
>   my $email_moderated_list = 1;
>   my $email_subscriber_list = 0;
> +my $email_git_penguin_chiefs = 0;
>   my $email_git = 0;
>   my $email_git_all_signature_types = 0;
>   my $email_git_blame = 0;
> @@ -228,6 +229,7 @@ if (!GetOptions(
>   		'git-blame!' => \$email_git_blame,
>   		'git-blame-signatures!' => \$email_git_blame_signatures,
>   		'git-fallback!' => \$email_git_fallback,
> +		'git-chief-penguins!' => \$email_git_penguin_chiefs,
>   		'git-min-signatures=i' => \$email_git_min_signatures,
>   		'git-max-maintainers=i' => \$email_git_max_maintainers,
>   		'git-min-percent=i' => \$email_git_min_percent,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

