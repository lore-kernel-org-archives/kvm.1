Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AB2E1F02
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847103; cv=none; b=StgfBis+JSw52wAK7hX8Chv5wI3VxwMDh3Lvdf+D//hP6notZ5Dr/8Xcx+n27m4MUiYE8NYk7zMALAgW4px6VxTYcaXXcAmQRcYRCHxv/NU8GOqcMFjAwxLTLCThJTO83zd96iteQYYpuv8gU4J4UpjkJB1g+XxKXDgE1829vOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847103; c=relaxed/simple;
	bh=Fvg5FU+5onnxA3JOwnqKcuKDQQNeL3X3+pq0iVePivM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsFb7hyVImmqbpGSAT2xv7WVfxlBB5HQXTBcR0nWpa0p8PKb+hxn4Wwkc2MvDGIB3zNnUvtFbm9cpTbL0OtAIQor2Qj/rSizHqe0BtOTLqPFNdhcgza52sjIc6r9iFuEMhZfYVsoUNqZoHFUlnmFJPumeqhG3gYI8cbIB1Gv2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBXoTrpP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBXoTrpP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c4772950so5655870a12.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779847102; x=1780451902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1E3c8UkJn5TWqrXNHTdzWU5tTA5LqbQi2KJ/n84lHo=;
        b=WBXoTrpPhPCzxF1AuGr2sdTRFbvG7wZBRE4wG4idPo3ZI5zNCmRSDAKtEiiLCPaNXy
         bFJzQ2/xOcGr7oKK2p8CLSKeY+53s9zS6n1nd/qZ+r2qqpMg32vQOn1ReyseOvyZSVuc
         i89d4EtLa02OQEZQsrjcbZDtbkoFcu2RpPiZDIckouf6wYLpnHVAhNBHCAaVcZodvMzm
         bwqWBHppicGB96TT3D46WA6vWi+xbXfIYXK1ytSKn9XYOVsna3kcKmtLxrRElHwVaqWs
         Op/zJInonBnma+sjcqByUtOe1+ACN04ruCzZ2J0T6C6u8PnwrCNydJ2bfnZ7M3JiaPos
         nBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779847102; x=1780451902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1E3c8UkJn5TWqrXNHTdzWU5tTA5LqbQi2KJ/n84lHo=;
        b=Ql+FzwB+YftuBSsUCLuM5E1C1x1KuERGrCTVy2EuhMHDYC0D8cRfxUuGMBTIpLQKKL
         gyRlIdY+30NEyQTWzVarWIJnemn67qAwVkSfVwwdx6Z9dtiStVzJItlDiJ1aGnHi5UAB
         JMobQ67gExKTh9LzUF7YYUhBoIubWSEJ1iOP/Swv6p64+h70ls6hKYzuZNXOv8pU13wx
         PQ9CzQuXsJZCQm2AZTzgICnk1kzSI2t4QdTAJ+TEjrln+Sgpbv0EC7OwlxOickGOxBG8
         asgpbs+14EjQmWzhiIa05KnYP6rQQ9u53v9hpUXqyIxvbLxr2exVCgsLZFYRu5kbChEm
         Cs1w==
X-Forwarded-Encrypted: i=1; AFNElJ/s5LRaSsgFW9x2YPx+d+y3niyvRNcYV5zOjQQuiElgeD79S1/Z+T11GrJZ95/SZY6bXBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wU5BccNTmN5EgvElnOLBwtKgWrhIByohdhb5q9aV2m+hNT0T
	MnXBvdFQXRQZMi9SYHh+riTeuN5JM7E3c9o1mIuVJG0eSlgc1Gpvkg3G6m9YQ6CUGCmEQLlLLhu
	S6EpoSw==
X-Received: from pfne7.prod.google.com ([2002:aa7:8247:0:b0:83f:1941:b9bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9062:0:b0:82f:53f1:1937
 with SMTP id d2e1a72fcca58-8414b552a2dmr19503226b3a.27.1779847101300; Tue, 26
 May 2026 18:58:21 -0700 (PDT)
Date: Tue, 26 May 2026 18:58:20 -0700
In-Reply-To: <20260421231557.1254270-6-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-6-jrhilke@google.com>
Message-ID: <ahZPvCt_8J86Ak3F@google.com>
Subject: Re: [PATCH v3 05/16] KVM: selftests: Add helper to generate random
 u64 in range [min,max]
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> Introduce kvm_random_u64_in_range(state, min, max). This function
> returns a random u64 in the inclusive range of [min, max] using a struct
> kvm_random_state.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>  tools/testing/selftests/kvm/include/test_util.h |  4 ++++
>  tools/testing/selftests/kvm/lib/test_util.c     | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index ae39c4293b9a..584a4ab43db5 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -132,6 +132,10 @@ static inline uint64_t kvm_random_u64(struct kvm_random_state *state)
>  	return ((uint64_t)kvm_random_u32(state) << 32) | kvm_random_u32(state);
>  }
>  
> +/* Returns a random u64 in the inclusive range [min, max] */

Put the comment above the definition (But thank you for writing it!  I had typed
up a response asking for exactly this, before I realized it was there, just on
the declaration).

> +uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min,
> +				 uint64_t max);
> +
>  enum vm_mem_backing_src_type {
>  	VM_MEM_SRC_ANONYMOUS,
>  	VM_MEM_SRC_ANONYMOUS_THP,
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index e342d9fb4771..23d543a9053e 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -42,6 +42,22 @@ uint32_t kvm_random_u32(struct kvm_random_state *state)
>  	return state->seed;
>  }
>  
> +uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min, uint64_t max)

Wrap.

> +{
> +	uint64_t value;
> +	uint64_t range;
> +
> +	TEST_ASSERT(min <= max, "min (0x%lx) cannot be greater than max (0x%lx)", min, max);

LOL, that's a rather hilarious error message.  Partly because it's so pointless
(gotta love TEST_ASSERT()), partly because @min obviously _can_ be greater than
@max :-)

The "min <= max" that gets printed is pretty darn self-explanatory, maybe take
the opportunity to throw shade at the user/developer?

	TEST_ASSERT(min <= max, "PEBKAC, min = 0x%lx, max = 0x%lx", min, max);

> +
> +	value = kvm_random_u64(state);
> +
> +	range = max - min;
> +	if (range == ULLONG_MAX)
> +		return value;
> +
> +	return min + (value % (range + 1));
> +}
> +
>  /*
>   * Parses "[0-9]+[kmgt]?".
>   */
> -- 
> 2.54.0.rc2.533.g4f5dca5207-goog
> 
