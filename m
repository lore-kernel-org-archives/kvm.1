Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793147222;
	b=IrHpb70CR2wEmtv6vpltQRCpsc30k7q9cZxyvlxE15BKr8I6fTJ/cX4FO/Wefz9nSQNE
	 GNYzxErY4J3c1bkqzUNyEK4g6gGHhO5fxRL+/drefhFujTdOMTPYfunSLPOJC03YMTDsE
	 rw9s89dbht/EU3EBYMrl6GlPvSfylhrJMoTPycuUBGLlFPT3vkgQMuAXacU7xxYGTIskd
	 N9iPQNUsPjIwEpWj23JwEwSI/nOKR8l4qjjRtCuxHmJ6UvV15hel4kLQU4erk4lUg5gnj
	 cKSj+brFc1uEVDNfmdVgaqqLP6n7LLMeIAyX38Vau6LTWubG3S8Khw9Alumn2FJNEhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
	b=FwNd9cYQp7mEmh7o90pTe1hD+tdvK41s4Tjcnj+KJF7FvM/k0zNjrE+JTDNtKgZWmeE+
	 AGfQw+iBDPRMWhf9U/L5KCtU32ZWVIuMGyfSzU8EpoFBt3KW+ODqYiHH2FuoCwDbzY9Yr
	 +UYDwYR8ZG8shRWx9SUbI4KTRXqlf13orsp76DIxYUeKNKHGSwwRPg5o+/gAFL3T3hoEV
	 lPEsBLtkoigOzqQn0EjJ8BfLS0A33Emt2/njdQjiCAlScnPKYbYi5vS2vsj6e+EGXaOzU
	 HfoeqbvssKgCDTU3fa9tDec5RxWY6sJaicEVawffM2d0FW4MbqDL/kPT+yJYa/2JfKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MdGXHYOI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77D606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 00:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE77D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MdGXHYOI
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8256106635eso238834a34.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147221; cv=none;
        d=google.com; s=arc-20260327;
        b=Je7WVvJmPQkGGOEAgM3DSQNU2CjFb4d4fQGNPoMGvANzo39Xk+unl8SKYDR216SF6u
         TjFWJL8bdqKuBJYOIiigQRMI3aoujimgmyq1u7L9PnYyRz6ZQ1I/YxSfi5lh9nI8uHkJ
         nyw5QCVsd5jRBYgyjtguAQkT/hwlyug+FIdUQP4NubFY05yCnCMqNz3rJPtrk4UmCnnA
         V5UH4rfVF7B8kA9HytbwYTxfacOSK4WyYr6Istmq6y4NZ0P5dGVWCswJygXRb51nLwjb
         Vzm7Purb9ewQYOzWGjwZWsAJLNVB8Hol6ophitbhoTzt9mqK7rVYQntRBScbDi0D2P2h
         JTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        fh=ekbxjf+3TQfQ1wEz+nNX+C0ohYMXWY9etPLoN0/LZNs=;
        b=hXXaQRjZGd1LAdBTLB431irj+L/FlCDW0S19O/V4z6AOzRjzjG7AbTO8+f7hDkyVNP
         6Rep9EDyyhDwvJrNgKkFZlC7NBu3c//92CG5Sf2pW7yASznGXUxCHxsZrXYKJ71iJ20q
         YuvpAMYbslDcQWBulcacHNiEBLNfmrQAlfIiNqd24Jdhms1b25yCUVBnsIcLah/0o7rM
         GtFSXNgs5UH18MY8bmm68jJvHBcF6AqP5MPCUbUbD2PronTdUIiCFEdIh+PNFvTdB51y
         vDhvHw6kG545tHlCUY7r4uafetJ37I/vSlmZFr8hCYvaK0VFnimyoFLnBfQNrkvTv2fM
         nFNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147221; x=1793752021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        b=MdGXHYOILDckeXuAUyH/Vk4wrEtmpanm61KqhMl0MQiPrdWJh2uW6MreM5CiOpDhrC
         vBgzTGgeKNr0fKVYpY+s+r/AsCQJ4hde/luBJ2/RF4Xrxwm0Pgw5IdE0OfNTqvQPcNuD
         b2+BXdKw6kPMxWo+mfi/5dLQNMu/w0YROhYFyW55sEDi7TWfU4GMduhH/ovlWO5Li+Lr
         0hbKXaiWZAIb9DbX4/lhRJS+T3TpUqnU1fw275TKcGBUGluBhVMyDWKMFcn7uCeYKRUZ
         Iit3TdmDQ0vXDWegWNcREmk2YwR42ij/6liK7noMDxBP1CwD1RV/DB5pgvgGwvLc3blb
         STRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147221; x=1793752021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        b=GMWAUWZiIuMFCM8/8BY5oWXncf7NjVCE4mW5cApV0P+GSkgww4JvZdHM29xUENOZ/S
         zB/TIJPCpinbaz/NSVAZI8vrfc0bLiyIaTmWblZi6mg66mMLQRrSPPc1ifGmFJQratxx
         kW2AWwYUhRHq1oYrjy1dnjEb3B4LlWVKt8Nt/UsXKiaJcFgoo40ZoKuq7AzfAZeTAoWG
         tqFlj5DQvZw5h808DnbQLLv4VurWVk6G/0hnvpZCOMv2O+5fQTjH9fU3o5BEOTPehqCL
         dUEQT0zQB1JxW+B0s0YTi7GjIoav8Bg1m+rO1JCzbwBTdWJsOGsE/UIR7/lWrXf6hBpT
         TOgA==
X-Forwarded-Encrypted: i=1; AKwUvBz+ixgp1nlVQuzpNpaSlHFt7hzXgUZ0mpB0BRvBzaRp69htw+FyiS7DI4UBfWeKlQD1Qpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3LG/jTARqjMmuYpHIUmV+dp9awoxNrna++90kWMf1iKpLQLV+
	jpWDaitrlui5+AvouZKPJbE/ZPT2MBCziJzrqqysDzjIU1mGmBl5de51cnY8PCpY8wE+ddTXYj8
	/BewpUpt2kfnkeDFkhGMDb2UjYSCCzKGwdR7gQeCp
X-Gm-Gg: AYBFou3BMvzemSGeG8lelh2J5PBFrqJOfs/fgx38dmsu1xsrQWzU1baKN6G6SVwT8Pq
	e4eJk2BPPjK5qDrV03LRxVmqNm7Pjxm+2lWSnLn53FZdrlJeNIbZ0eEzjWqobVdJV6s0qpfSzVf
	eA4SlYU4gb4Bi5G2eKAEQ1epOmTp3F5BkVAfvCUme7Sz+UOQD8yR7HIvwFXIvd+guVZZZUFJoe5
	YCdMZ/PsBD7AIAwX6K7IAQg5eKMglNv9mXBloI0yFRWtpXzjTMofzZqBmU9Yk/+dZjuGftQ0n96
	Izbs4uAC/cQmSCUyVVELcTO63hmQ2RZ69OgC4unuF7K25INzJMzwK5HDKtla9X8Bpcv7Mq60ULg
	rs8pjgXMUA8JKbXIi01D3M0QOdCwtBvtbZJIHan0R/1A2bQh0FdSAQ3AC98hO2gHehlIzjjCTIH
	MSkE2OItCxC1kiq4oEFoPw7W8SEg/giSOE1HMjVPkE2f7du4tH78oOwsQnZmYli35ddYXn+j9es
	zw0OPah
X-Received: by 2002:a05:6830:230f:b0:7fa:5c68:d053 with SMTP id
 46e09a7af769-85ac14a8d6emr843028a34.29.1793147220374; Tue, 27 Oct 2026
 17:27:00 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-9-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-9-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:26:21 -0700
X-Gm-Features: AclHuK9X9-tagkcZtNpeYN6-ZH2xFAn91vEZn2rqSYOeh808Aib4fY8cPgUneqg
Message-ID: <CADrL8HVtDucwUSnZVb63pQPmo9YJksSTu+E9dDYgB2sLQ_N-ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] KVM: WARN and reject guest-based uaccess if VM
 is dying
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> WARN and reject user accesses to guest memory if the associated VM is dyi=
ng
> even if the current address space happens to be the correct address space=
.
> Accessing guest memory after the last reference to the VM has been put ma=
y
> be "fine" from a safety perspective, but it's still a KVM bug.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  include/linux/kvm_host.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f3f59bdf7e18..ba8ea62b7304 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
>
>  static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *=
kvm)
>  {
> -       return !WARN_ON_ONCE(current->mm !=3D kvm->mm);
> +       return !WARN_ON_ONCE(current->mm !=3D kvm->mm ||
> +                            !refcount_read(&kvm->users_count));
>  }
>
>  #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)             =
               \
> --
> 2.56.0.307.g5fe7bd680c-goog
>
