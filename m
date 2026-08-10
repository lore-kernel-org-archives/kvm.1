Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92D415F18
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379371; cv=none; b=lSlXbHv74CvQRwKUb2xAzXSO1H0OdeC4z8gf8juZKZFslT0Ys1BEHTSGB2pmniFVBCZKQihPfgzXYBx9j8EBF4mdz23cIAH1PJzSFbhd0fOE76meZcD9F9AwVrasPpxgw45ZP9D3d9ORSeuiLMQF3p6P9O9ujzB7+J9P4Lr67Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379371; c=relaxed/simple;
	bh=cB3t5Wt/v5lqDAqABYRu5BRDHci0OZngRYQCJr4+fBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7TawR0/o8oTQ/Iwcedi/htyjuU8fNGTjuhLSvW7RRvfaLKVr562ZRSScBO751gM7n9jcitzvJJRHAL91NCXRXvh6M0nho1YCx6J7rXrygU6RWjMzFZpQrzmMEGiQT5xBDDtX+UXjOO98KDFL5j6FNOKsSG4tCG64iibrlGk9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBH6kTaz; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBH6kTaz"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1271410a12.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379369; x=1786984169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRqatjF6laSho8dqZBckVCKdXvkaRYO7dn0sgVFL7kA=;
        b=WBH6kTazTNHPlRsvqnx9brrHzrFQf68MzfJ0K5iy7KPSDrOwyNJOQ4qxLGx2u3WDHV
         1OX4Jw7mCjbcjyYjOPfHwNXiU37XKpYHEL91dFLtnqIP5CdKws5fKdLQaWixAbyrFlGu
         JTWcEvdu50BrIJjyjcRIb4p89CI8UWk705joWeXrQ51CCvQVfHzSMAgVzdP9FTK7n3Aa
         EU9epKdh8DsRsBrYI30xKlca6R8ZNlTaAJ13OSra4cIH2AZbjM6ioLZMuG1JX2+IIADL
         6fXfH5tAHsHbzMGQP2kyh1NDg+xJzPfjkgwj0ays7jZv/7gNGmH9x7811i2od5L331Dj
         ZuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379369; x=1786984169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRqatjF6laSho8dqZBckVCKdXvkaRYO7dn0sgVFL7kA=;
        b=cUdaffpCnM5KKD4JvM12oSRaEOTkjnWS/WhieivT6L4YdLbAA+CRdfp2j9jLWnSZDO
         0Gx1KLP6sdByxk1aFOdg21TqTEaJ/NfNmYyOzLF4E5rc1pWTl2eiejBZZXtkIP8OE36/
         Xzk1RfJ5e+AVPjHU9sG1NaKA9hZFsW3f00tmHc/HKJXegF6XpI19mNnlecpZckpDsfPx
         MbV/TeebfKkdRZ+UkgnfK6/ONQtnQT9+GTA2x35MNAHywbvAeo0H7iMoRYE92qL/45Bx
         MTpKoUwRNJgqirUuYfJo8vi6GZIFnqsZgU5MhwLT5H7pfcS1HUMDE4gcFxi5BwNQ9D+P
         nWXw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+GbujB3nAhUZrY3DcHCzN5ojx7W8BDVVG7QVunMb7ASPkV5BCoILdJFFRc5T/enGGxlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJmQwWZ7AlgBaowONMsTCwvropUSssN7bey+1qbRIHnZ641hJ
	zwlsY1yB9IUY1I9wUML7C1LvAd+MEj5HPayAz5gBXVCuH+QdZJRVRXlCGExrV6WcNBsIcr4126U
	/wu3EBQ==
X-Received: from pgki17.prod.google.com ([2002:a63:e451:0:b0:c99:aff5:7092])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:69a:b0:3c8:e313:8d42
 with SMTP id adf61e73a8af0-3cbce96f6dcmr23916356637.31.1786379369244; Mon, 10
 Aug 2026 09:29:29 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:29:28 -0700
In-Reply-To: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
Message-ID: <ann8aPLSgLzz_6L_@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
From: Sean Christopherson <seanjc@google.com>
To: Jann Horn <jannh@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Jann Horn wrote:
> set_page_dirty() requires that the caller holds some kind of lock to
> ensure that the page's mapping does not concurrently go away.
> That is not the case for a random page we got from get_user_pages_fast(),
> so use set_page_dirty_lock().

FWIW, I verified that __kvm_gmem_populate() unlocks the destination folio before
post_populate(), so we shouldn't run into deadlock when in-place conversion comes
along and userspace does something odd.

> Fixes: 97cd21d57e9b ("KVM: SEV: Mark source page dirty when writing back CPUID data on failure")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Note that I have only convinced myself that this is a UAF bug by reading
> the source code, and I have only compile-tested this patch; I do not
> have SEV-SNP hardware to actually test this.
> 
> This bug was introduced in v7.2-rc1, so if we can get the fix in before
> the 7.2 release, this won't require a stable backport.

Ya, that would be lovely.  Paolo?

> For context, I have seen similar bugs (set_page_dirty() on a page from
> GUP) in two out-of-tree drivers in the past, where this led to UAF.
> Evidently set_page_dirty() is a bit of a footgun for GUP users...

Heh, and that's a bit of an understatement :-D

Reviewed-by: Sean Christopherson <seanjc@google.com>
