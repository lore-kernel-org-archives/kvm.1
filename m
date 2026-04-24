Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954B54763
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015926; cv=none; b=Q0rNu2Iguy+zlWdKal6GVbl7eqzajh65VWFOlFhTpPMiqimKcoP66kZEMgURFxiiRC+cg/V5DR6O+naHRlJR3fqDltbZwpRME7lZVte2L61JwRf9bXjN10tQqdMuHkhcY2O3sfTYtyh8TBLKUH4pgPrSZX9BkgrLIFAA5FtwAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015926; c=relaxed/simple;
	bh=6Gnghml8Lif6S5PnBmr6tPtdsbaqY216/IVgDv/vbT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJE/nWXlMcrqpHS0tNMS5Xji+UgeEKcwJKV1H3qB+0N9czcX+Bn+NLNNg1NaFzw3mbo56LxC97VvVGw5fItcbNDUVDDvhFjhVIWiiJgm6R1JxxMEPziiIHe3QPHeFlaiiFcPcjWAi/DCe+a+fdYhHx4Ra+2U8IC6a6mMR96QT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUxtARzV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6qz0d6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUxtARzV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6qz0d6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777015924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXM+JOFEp4FqtdTb0bwZTt9BrwdIgGJqGWwtjuSYcM8=;
	b=BUxtARzViC9cc+dWXkQlH22B+Gv4NxYEAUWsJdq18UviHNjd80HjFhUkq220bsvdOzHK09
	b3F+wWgR/2Trfc6ter8hEp17jI803oBeJCV10gp07jwzwXp3Utq3tW/QQtnYZTo1ABDP+5
	0c39tFPC34bZfTBur0vJj0RcaUHOF/8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-DIG5MgqCM9Kaqyuc0ru3KQ-1; Fri, 24 Apr 2026 03:32:03 -0400
X-MC-Unique: DIG5MgqCM9Kaqyuc0ru3KQ-1
X-Mimecast-MFC-AGG-ID: DIG5MgqCM9Kaqyuc0ru3KQ_1777015922
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7976ded5c5so7949038a12.0
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777015922; x=1777620722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXM+JOFEp4FqtdTb0bwZTt9BrwdIgGJqGWwtjuSYcM8=;
        b=T6qz0d6f8hgAg2NhG7FoBfGIVaXhJaaenk7PUdFgD4ZT9ZY7XfFVQQdaQiFOV/y/e9
         MVJxMLmwNQw7FoYpAMK+h0NoqIFlk3VcNeVAVyfkKljeHiQpRUkFtSl3M55zHwiT0+0s
         moxnZKw40Nh43gGUjK9H0Rud5XN9Spxk9hCYscnZEwWRMRQMHHq0cXkZU1TDhstQjFDh
         hpZ7fjDYRay+LAkXH1YvOtZX4FA4Iudoj+KhWKxILHtmKL4TtHtAiFkVtqcApX/9I4Vi
         qgqQsMy8TRnPHjhfCxB6tvZ/e2F1K8wkjV22Gm6UzhahiJThQ4pg1KvYcE4pOaMt/iDL
         ac1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015922; x=1777620722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXM+JOFEp4FqtdTb0bwZTt9BrwdIgGJqGWwtjuSYcM8=;
        b=l1oMKaiM8oyYK4lerbl2VighBh55OD549RbJu8Mo4VBHuK261gwafCGxuIoDATs+6Y
         +tiP2OnZZZYecP275WX4h6jy/CBgBDoCd4XKYshrxw3UROYJLCgvGEU+RYaVyyQp3Q72
         Lx+ra0a0i59YKFzTi8vLJLzFJYtYToPtTJh+39fS9WHwmHo4ElxDO1a+CAsBoHM3Smm2
         24+JrxJ6NH/T1+JVgSiYE4NBPa8TPAMR+mUMRSiUzBuAEVsYNGzCraxwZeNku20629oX
         dzSYAX+SgCyFA1uiqViiD+2gGfPzLThI6q4GydjvjBwMaUtXgYX6ewb4m49l+KgXEDzB
         ecGw==
X-Forwarded-Encrypted: i=1; AFNElJ/8NrsCeufFXiqK3GLYV2S+AQYHd3NudxUOfHy04E47gR8cxWx9iHw8OvvItSWCWx3tQ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCtbBd453d3ftZ38wynrUCNgNCt295u2Dnvj0UkYM0g0gpOw4
	DXqrP6YcmB9NCGFlY11wZB1OdAXae1RQ8MKc+vE9o9JuTtF1iMTGEjhDIS/FcFNH5VoT8bMK0FQ
	W1tMak3atk9lfbOnILH4p1aPC1nZhQZ8gImOugPaITrluJDb0YFpEmyPF7Wp5AA==
X-Gm-Gg: AeBDieuNTJf7LOFApwaAdBV2ahn28v1OH0o8wOsPa4PmsMpRZRO1eif5U1VW/x9J0j+
	c6ooi9GEeVizfmChBOyVumqNVd/ONYO+M8fOmb+wAgYj/2uB+xLSpCEn+PTGXkChjqYGodnoz5/
	7ceqlyCtzBwIrpNpGT89xlDynZRoE+94hkHSECpLosyMiIKLdZ223X6TLnxlJigcW1LnzjTjZSL
	DF2HHc/B83kh1rZS9+x7sdZlTiFKFcU+zbK5smpjUFC4eK9aT231Lha0Lz3bz64CSgwJLw+9eoT
	CYe/nsxwRgc5AUcY92baDlmuUzUnChSsWhKUi/7Y3VvHby1WLFm311Z6yyCCF/sNiiF1cjPo35N
	TuwkhV3H5WM4LLJONmkr0LAzqUL6Sig==
X-Received: by 2002:a05:6a00:994:b0:82f:193f:807c with SMTP id d2e1a72fcca58-82f8c7deca2mr33107422b3a.2.1777015921853;
        Fri, 24 Apr 2026 00:32:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:994:b0:82f:193f:807c with SMTP id d2e1a72fcca58-82f8c7deca2mr33107368b3a.2.1777015921280;
        Fri, 24 Apr 2026 00:32:01 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8317076ca48sm5225402b3a.35.2026.04.24.00.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 00:32:00 -0700 (PDT)
Message-ID: <6761d631-a714-420c-9c2f-258aec664d17@redhat.com>
Date: Fri, 24 Apr 2026 09:31:53 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 3/3] scripts/get_maintainer.pl: Ignore
 --nogit-chief-penguins option
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
 <20260423-b4-cmdline-v1-3-f72ad0020d42@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260423-b4-cmdline-v1-3-f72ad0020d42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2026 16.16, Christoph Schlameuss wrote:
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
> index 117b69145f0e..9b99f6218467 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -31,6 +31,7 @@ my $email_fixes = 1;
>   my $email_list = 1;
>   my $email_moderated_list = 1;
>   my $email_subscriber_list = 0;
> +my $email_git_chief_penguins = 0;

The variable is called email_git_penguin_chiefs in the kernel version of 
this script ... Could you please use that here, too, so we stay at least a 
little bit in sync with the kernel script?

  Thanks,
   Thomas


>   my $email_git = 0;
>   my $email_git_all_signature_types = 0;
>   my $email_git_blame = 0;
> @@ -228,6 +229,7 @@ if (!GetOptions(
>   		'git-blame!' => \$email_git_blame,
>   		'git-blame-signatures!' => \$email_git_blame_signatures,
>   		'git-fallback!' => \$email_git_fallback,
> +		'git-chief-penguins!' => \$email_git_chief_penguins,
>   		'git-min-signatures=i' => \$email_git_min_signatures,
>   		'git-max-maintainers=i' => \$email_git_max_maintainers,
>   		'git-min-percent=i' => \$email_git_min_percent,
> 

