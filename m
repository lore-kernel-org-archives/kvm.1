Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927C33D4F5
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930633; cv=none; b=DLn1Q2aHq/nYD5HbCXi6EWJbqBkUsNwv4bYDUFAa843cZIezOQLufmd8Fh8FQwrE82wrxrxEGSbwvSNBecVqZd2qKgNNi4qchoXoc8pFMJKDBqtdKQNIpt1RnNofj8KnUYRbzSaPKpO+XiQUTYYaBQmCmMHRHqCFefHp5AGQrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930633; c=relaxed/simple;
	bh=IgtwCmjndgaX5VLGbpmx2IqtuMX+Uwr5274d8PnIO7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1jtLnKP61tkvE2t/bqoCS3cq5Wi/USItYVcS5Hun7eJin8fOAglXfKEJwzmIZaWuE/a5ONs4yEWX9jJ4R8g3fXt7NrCOintI/1q7CcsEYKn8sgi+TMFtnuWgdCQrDnW1hPUKWKAh5trWRDXYjdJbx7fdKddnr7PSRYQYwgVDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGA5bmT+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aH9RIC6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGA5bmT+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH9RIC6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7M6hLcNsYTpn8pFlak44q94E8+lDHFczoYFSZXMpddI=;
	b=VGA5bmT++lSX8konl+5rUiItjTiwdYUe6fhvpu+VLBUHiW+dM9Wl+3eAqDjmNMB8rsreYC
	sJVRQEhJVe31nWf3m6b+K2gOteX7fY35k3sXxlzYJCbNv7Os+ligGN1xRt8pyjBYs/Q4y1
	aDZq7bBAfS5YOtw3uZ+eRCs1VgupLOY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-C1BjHp2SO4GwzXcT_bQ6_w-1; Thu, 23 Apr 2026 03:50:29 -0400
X-MC-Unique: C1BjHp2SO4GwzXcT_bQ6_w-1
X-Mimecast-MFC-AGG-ID: C1BjHp2SO4GwzXcT_bQ6_w_1776930628
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c798fc1a426so2018332a12.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776930628; x=1777535428; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7M6hLcNsYTpn8pFlak44q94E8+lDHFczoYFSZXMpddI=;
        b=aH9RIC6IMgKWJJ/9wsV9feHrNvlMacZPgZ01bFFqV10zrEMimmDTM/8ZeHKrmzgH2m
         M6cgg9Wsj8S8UmztldG0PkdQzjaDn5Ichql/GLtJwiGz0bN91B8sUHlk8Q/Dj8BIqfIu
         BRjhTI07WFuEaxUOSTJN/zzsaYrED1kqBSfSIY6wcmK1IMNVCF5rBgRQpvZllxC7R0vI
         lXV+80tUht9im8lbN+tJOXzaCl591sWWyyUQonWBwzWAaWUmVuHCQWioZu1UO/MrOMin
         b1FAG6agOiProfaAvy+wuieuttSfn2nDeZXLqUgVEgjRG21+dNBHHw//fzQgblpP1+B7
         aRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930628; x=1777535428;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M6hLcNsYTpn8pFlak44q94E8+lDHFczoYFSZXMpddI=;
        b=HL3DAOgshcqoq8gGzQU6LAtuf6qOy/NuoVbuGIwQGBoM5IZAzxtoWwzcmImky4jPEc
         6Ex2o1Q8FypxQfab63HwS+89TRpKzuyy8zHc0l70QqJ7qYde+klMbVGadw326qGdBkED
         MASBYhPxuPB4uGZwPs8T09gcWV/bGnaEOE6P0RYaGgYmoP6iSIdafoIcLsS8RWy+wfnv
         TBZYzts5mime9+9dGCeR3UPxhcvxW9D2ufI2GyGlWg6/aQG9WsPCyN26LWTGcaYRuEOK
         n36HrE0xBh7vC6hrT32lQC7McVFeXh8NOPl1rTiftKQEmOlPVVgBu0CTeTgIc8HzNsuR
         AKaA==
X-Gm-Message-State: AOJu0YzsOYMvlQ2uxYe9RLHabyCJDiDvcJ624TgqGoDaqhmK4P/MXdAg
	LxurG9xWXkFRKAdWQxSIsbGOWWdWNvzfy3pAlFCg56UxPaBrNu/XesEnO+Q3Uvwr7s7S03pAn4X
	jBDEDkkzufyVdOauEN67UH7KOL5klBssm3mqt3+QnsNL1eTWQeZE09Q==
X-Gm-Gg: AeBDietym4thg2qqo+WIlJyw71mUKe0fJvKS700tCWvtsAYVzqwJxfdFo76wPhxkDk6
	cxrEAGTDRLOK04c+dVpEa5kVq9/mPfunOq8G4nyhfrCMCvB/iUiBeoBgLtPUiHMhHL/HoFNlQV3
	o6ClFLwUaYeSuOpFcJDiakuR0zljC+HWMSB/U6Z78h09OymTXOAi/n+N3RTFeI/IHd2cU2J3Xm8
	+sx0x+DnJIzeWkxAN0rv6NdeRjq4OeVW5jC7nX1D+dk488qzIjjNracm9lAiv48OlKuPduPJa8F
	LTDSZjEraPYV1xcH9x7RfQ+38W8mLINclQdSR6PZxZkhmWxYS3WmqBZsGMCaIBgJzmUPQ7YtK5v
	uyuWAZ5ObnIwopGJk7EJhXi2UHjJb
X-Received: by 2002:a05:6a00:148e:b0:82c:9cd2:fee5 with SMTP id d2e1a72fcca58-82f8c87e28amr25577176b3a.7.1776930628196;
        Thu, 23 Apr 2026 00:50:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:148e:b0:82c:9cd2:fee5 with SMTP id d2e1a72fcca58-82f8c87e28amr25577148b3a.7.1776930627699;
        Thu, 23 Apr 2026 00:50:27 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec23b19sm22580923b3a.59.2026.04.23.00.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:50:26 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Piotr
 Zarycki <piotr.zarycki@gmail.com>
Subject: Re: [PATCH v2] KVM: selftests: hyperv_tlb_flush: replace NOP loop
 with udelay()
In-Reply-To: <20260422130307.1171808-1-piotr.zarycki@gmail.com>
References: <87v7djgoji.fsf@redhat.com>
 <20260422130307.1171808-1-piotr.zarycki@gmail.com>
Date: Thu, 23 Apr 2026 09:50:16 +0200
Message-ID: <87se8mglon.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Piotr Zarycki <piotr.zarycki@gmail.com> writes:

> Replace the open-coded NOP loop with udelay() which was added to KVM
> selftests in commit 6b878cbb87bf ("KVM: selftests: Add guest udelay()
> utility for x86"). The NOP loop is CPU speed dependent while udelay()
> provides a deterministic delay regardless of host CPU frequency.
>
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

> ---
>  .../testing/selftests/kvm/x86/hyperv_tlb_flush.c  | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> index c542cc4762b1..4b7f089542c1 100644
> --- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> +++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> @@ -141,17 +141,6 @@ static void swap_two_test_pages(vm_paddr_t pte_gva1, vm_paddr_t pte_gva2)
>  	*(uint64_t *)pte_gva2 = tmp;
>  }
>  
> -/*
> - * TODO: replace the silly NOP loop with a proper udelay() implementation.
> - */
> -static inline void do_delay(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < 1000000; i++)
> -		asm volatile("nop");
> -}
> -
>  /*
>   * Prepare to test: 'disable' workers by setting the expectation to '0',
>   * clear hypercall input page and then swap two test pages.
> @@ -169,7 +158,7 @@ static inline void prepare_to_test(struct test_data *data)
>  	wmb();
>  
>  	/* Make sure workers have enough time to notice */
> -	do_delay();
> +	udelay(100);
>  
>  	/* Swap test page mappings */
>  	swap_two_test_pages(data->test_pages_pte[0], data->test_pages_pte[1]);
> @@ -189,7 +178,7 @@ static inline void post_test(struct test_data *data, u64 exp1, u64 exp2)
>  	set_expected_val((void *)data->test_pages, exp2, WORKER_VCPU_ID_2);
>  
>  	/* Make sure workers have enough time to test */
> -	do_delay();
> +	udelay(100);
>  }
>  
>  #define TESTVAL1 0x0101010101010101

-- 
Vitaly

