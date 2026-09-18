Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61C50E5A3
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748697; cv=none; b=PTCplk/4bu1yRln1ns9+krUPViBywh8pSFpMhQQzrB6yUu17R1x2K1YwkEVL3r5AgmFgmW1iT+vqgl9MLE2ZAznkW60lVQwrQiDeJ267WlPflaGjHiioYry6QE83ancpZ+G0EI3E2OXQITPfn2c/sNkSy5HEB9/sq9BcnX4lV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748697; c=relaxed/simple;
	bh=/VEJ+LucLRgG3GQveLMeKu8gGNtxOYLsCkVGmvtubPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQmAJNNf6sWgwvE0K3CDBBjsactuunxcdVplstVquQoQLMMcW+pC/9/19+mAU91uuw5+q54UN2b4dhlpCqD8VOkiNy3im5wdZ/ui43+Q7hKHvt+RwnrhW3u+9LYtrgkNZin5YWhOB94LXqspUxlNJcObdCk41SUsId2pJUR0qtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NypGK/y/; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NypGK/y/"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so1264157a91.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789748694; x=1790353494; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHL6ulY39G3oYupBS7XaH4v+pqwb8EWJ7uPAAnt0DUo=;
        b=NypGK/y/QMSj7kykXuqffJBWeSeURdROrAIZpIjuU6YeyErphUB3XGkaWeL2TTFWM7
         Dw1NqYCmMfCvkxWkgE9RsPF44QZMqZRzbs9CW0P87Ol92pkhzwkm08TuBGctGbDyvkpt
         5v4qiJQy1BrdD1A8GZ4Q8RiLJWn0xo3RmKll+MD+wjEhuk2UXDQD+1AfVFh6QMlzhds5
         t2AfPNf7zS8NHrsQAYAKI/QUWS8gi2xZNh//prS01ORUYnKTDn+eBzF7YM4yBH6rzlt/
         JxarJucsIc4pVy6OOg1TwahbnKgkf9bOT5CPlDV5G45LBUzqaecPyYQVh52tgfTS1sYR
         GoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748694; x=1790353494;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHL6ulY39G3oYupBS7XaH4v+pqwb8EWJ7uPAAnt0DUo=;
        b=QhKMfcZ9AmLjyNUC/LB7xybkFfJLA4kouuaj5U7LwXK/I2ruQTf0DbCn7IZe+MbvZa
         qX44eKP/aJ+SiyQGDf2RHRPupf6OMPcRSOw6hdS7p1lTfFXpZnYsp2rGnDOuPg6aJPUQ
         g9FWTQtYCmGMF0Uhb41HcmO3cupTd4N6dWkRIJxkln9Va2bH2oPZWTab5VBQeE8axd0N
         CqjI9gY5l3AYDC0GxGAPiup2jKD6xLbISCiSQtfaZDGOzBop2+zjOBf6ZPgi/PDrQPqO
         YnrJ79sNcX54vR9y0FccVRKdsOKQb1mvWvymVarrnpXJ8WVbhOIA/V+YVPGfIol7aSjO
         b5pg==
X-Forwarded-Encrypted: i=1; AKwUvBxF1NC8kRyEg94fzznSZu3u0hgA4E3KozSvppgIH1+ZfXx1zJDUVikzDYPkvUIo3GBwJKo=@vger.kernel.org
X-Gm-Message-State: AFuF++kg9zhTEcwX9TZBp/GJvdJSkUt6DOmFCpWFFTthlmju9kGDKFL8
	s6lCbQVjDHhPoXeaM1bh0cxusafOB2LCWPAhnn9ViGLEoLFA7yxt3627xvNahJHlsrRdIgV+hlB
	3b+FabQ==
X-Received: from pjbiw20.prod.google.com ([2002:a17:90b:4214:b0:39e:ac:d0a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d648:b0:39e:6c6a:4b6f
 with SMTP id 98e67ed59e1d1-39e6c6a5502mr182977a91.57.1789748693726; Fri, 18
 Sep 2026 09:24:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:24:53 -0700
In-Reply-To: <20260918113631.634233-2-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918113631.634233-1-gokul02k@gmail.com> <20260918113631.634233-2-gokul02k@gmail.com>
Message-ID: <aq1l1WwdySbfX0qt@google.com>
Subject: Re: [PATCH 1/3] KVM: selftests: Delete the unused sparsebit copy and
 count helpers
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Gokul K wrote:
> sparsebit_copy() and sparsebit_num_set() have no callers.  Nor does the
> FUZZ harness at the bottom of lib/sparsebit.c, which exercises most of
> the rest of the API and still builds and links with both removed.
> 
> sparsebit_copy() was the only non-recursive caller of
> node_copy_subtree(), which leaves that unreachable too.  It is static,
> so keeping it would trip -Wunused-function; delete it as well.
> 
> The comment on the num_set member gives sparsebit_num_set() as the
> reason the count is maintained.  The member stays - it is what lets
> sparsebit_all_set() answer in O(1), and the dump path prints it - so
> point the comment at what still uses it.
> 
> No functional change intended.
> 
> Signed-off-by: Gokul K <gokul02k@gmail.com>
> ---
>  .../testing/selftests/kvm/include/sparsebit.h |  2 -
>  tools/testing/selftests/kvm/lib/sparsebit.c   | 63 +------------------
>  2 files changed, 1 insertion(+), 64 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/sparsebit.h b/tools/testing/selftests/kvm/include/sparsebit.h
> index e027e5790946..8a2ab11dae6f 100644
> --- a/tools/testing/selftests/kvm/include/sparsebit.h
> +++ b/tools/testing/selftests/kvm/include/sparsebit.h
> @@ -30,7 +30,6 @@ typedef u64 sparsebit_num_t;
>  
>  struct sparsebit *sparsebit_alloc(void);
>  void sparsebit_free(struct sparsebit **sbitp);
> -void sparsebit_copy(struct sparsebit *dstp, const struct sparsebit *src);

I'm somewhat tempted to keep sparsebit_copy() even though there are no users.
In the unlikely scenario someone wanted/needed to make a copy, it seems like a
potentially painful waste of time to have to recreate this or hunt down its prior
existence.

Anyone else have an opinion?
