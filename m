Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF051A122
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792485; cv=none; b=KJLY2f6vVrKIMcmAFSySFrzFySB1vXOSfLhDsZfDVAJuHJcvzT9he9hH6AqnkfwcvlrwrW71eMwV6IpUd9AMnmr5LDCHyd0GGNeSuwC0NDLyxYfegicRqzPtIXZDpwktKlRMvmcJo+OoYL+L54+HrgturO6qUofASGryIh3ebbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792485; c=relaxed/simple;
	bh=RIBmG7T5GhMUhIGxO0Hp7Z1fyqLfGep9Ek3+Z8JVsig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLDvdjKYE3++uqNWq7kAzeRaaOJLV+N9wJlqMro/9RMRNG5Hrt1DXNXAOlPzKTC4NBViT+FApbGF/7e10vexqwXK+oRKw59FXjSEio5PyEK1ktKClelasyGIkOtMf9w7pUD6zFtIql+poysmWzsi4kFj6LqGhSLLLjgMc8yXSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVnn/a0R; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVnn/a0R"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso2053557a91.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790792484; x=1791397284; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6jmdTOoqfk9NpdkdE3nQvbuTvNJoC6kAafCKfbFDU0=;
        b=YVnn/a0RbTlgoCQZjT41jwCnxNpAoncS4cDGqshP1BFW0tYennQbyWaUv2jiQpio3F
         +d47g5QWobqEAcZBUSzqtpdlT208Iy5+IxcQjOQOdtHZGWMPytZR89zASn1iqpkN5/Ou
         gJDhB0zgSjWAlPHQkP8uB+OiiBfw3fRP3WW3zkdt8sgggUTB+LZO10n3SoyhFAMsltap
         OjoOQMsY+WcVQIxxpwP7WnQssksTJKxleiRSA69UEdhmzc0HZ22tYI7SxagN4YrWsWEu
         ZrDv7fC0CwTwGpRD863RCQSFEQysjni7UwrcPOnkcUcWsZqD2/4aGTxEiB+rYWJoDm8a
         +vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792484; x=1791397284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6jmdTOoqfk9NpdkdE3nQvbuTvNJoC6kAafCKfbFDU0=;
        b=xmdJ1/4pDcX4l3ytO/QtXFRMLRvk5ad6RgxXl5vQxrq/b5VKNC3c8F6XhsDMVYVLoo
         FT493Lid7YCNDoCn3he9++Xrc9lu1WsemT7Ib4BVl9e8i/NxgZdXCb8Id+GFQ0fS+BdA
         yLAiU/vCA0hTV9RaExtHum3yWSLcIoiSPm3c4ezd1o0KQSJ22U53GNGhvo1VKy+RoEkc
         n5S9sKfQ8HaUa0Yg5m02yUtO5X7N1GkjMS2UoagPAZT1tG+upprF+YQpFYj75SNt6G03
         w2924byE+5uqsSu7DJg3Gavc26RlMWFfmjQVFnZiAwPA7gwMJk4O1F0ziufYGkVrB02k
         2psA==
X-Forwarded-Encrypted: i=1; AKwUvBzL9pP0Y41O3eBQIbe94qHy6eHTobQ+zPAfVGCUG++XPpCCvTngPxrGACRMQf9vVB6g0uU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlpSbpNDW81zpEKxRKIJ+8fpVLl2x4SJJy8I22FaNbvOAeDSgm
	i1JDZJ+oZrSwXhryJR6Y+EWy4DXDTWn8outqz6swV7po0WUWFNPt1H6cZtP56LQYTXq1spFvgPU
	5ffrchw==
X-Received: from plrp8.prod.google.com ([2002:a17:902:b088:b0:2e2:aae2:7762])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b43:b0:3a0:c276:1ec0
 with SMTP id 98e67ed59e1d1-3a4d1654d49mr2004241a91.28.1790792483132; Wed, 30
 Sep 2026 11:21:23 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:21:22 -0700
In-Reply-To: <20260929113711.2064390-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-2-leo.bras@arm.com>
Message-ID: <ar1TItRR7o789i6_@google.com>
Subject: Re: [PATCH v1 1/3] KVM: selftests: memstress: Add option to enable
 dirty-ring on VM creation
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Marc Zyngier <maz@kernel.org>, Josh Hilke <jrhilke@google.com>, Oliver Upton <oupton@kernel.org>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Steffen Eiden <seiden@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Leonardo Bras wrote:
> Dirty-ring should be enabled after the VM is created, but before the
> creation of any cpu. To to so, add an option on memstress_create_vm() that
> takes dirty-ring size, and enables it at the correct moment.
> 
> This required a new function memstress_vm_create_with_vcpus() to be
> created based on the previously used __vm_create_with_vcpus();

Rather than pile on more params, if I ask really nicely, would you rework
memstress_create_vm() and friends APIs to take a "struct memstress_params"?
Except for dirty_log_page_splitting_test.c, all of the memstress tests already
use a struct, i.e. while tedious, it should be straightforward and won't put
undue burden on tests (which is why the core VM creation APIs don't take a struct
of params).

Then it will be easier to extend memstress in the future, and I suspect the
existing code will come out cleaner as well.  E.g. dirty_log_perf_test.c stores
nr_vcpus as a global, despite it being fully contained by main() => run_test(),
right alongside the test params...
