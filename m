Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2E3C81B9
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975254; cv=none; b=hQOHW+vbd2pGroqkwwXiN/U24+yUvUqokv0VbiAiKsshmvpGoaeb4BuUif30fRDl+rM9EPOmHwb/HwcuLEQJJbwnEUTwEmfRi5jKXYO1Clh8HruJXznuy4GGoWdT04B8akHcfvqoadRT7QfoY6cLCRzOX9AyB1lhXPSTO9ZTl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975254; c=relaxed/simple;
	bh=+xl+T0Sx7GPuJ5gjwIw2iwy4OymTW9N3iDiRd4D0bPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JL8MHYFJ2fAGZnRgEvuH01fyrcT8MtnVc4VyWzxZr2XjxCA27XkTTXZRmkkDQLy6dKv4s/L0anL46Jq76LKZArZSCH9R5AelW2g1rhGgK4GJluM0DbNGezoXNzNqP7LD+eswUrW9GBYBw7ndnEdgmGQAxe3I6U0ze5lgXHuilFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWQrLE+X; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWQrLE+X"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc72777faa2so16075a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975250; x=1791580050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuSQMenX/K36z+uq12eSp70AMhTM9Kpsrje6PFTIDvw=;
        b=nWQrLE+XViQp+GzSVijIqzvQNsM/wzb92/VP3moq5FH3N6QmAbrA04fQgmWkGwuhIh
         dsHi/N+Are9+Anb9BinLT1oXUFHGTQGJeiNhdNcCAmCg2biuwVtigJLHHG/5OFI2UxMi
         Z77mR6ZHxznewBVBFhfPGyxWX0aaaCFcWJimaIxTiyXgY5sS39fBwmX3Clgz1ahoHjda
         vi9HIkotXTCVqWI0taVbcZ6U742hCTpdnxgUWLZiMbt3YynS15j3sUnilZuGGnrlIjxE
         opJpNzcp4SFfXjNENPFw3KsjfGff4yOFyVuEPnm86nXGL77cJgbRrBMUVYyrkRYRTIoI
         n8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975250; x=1791580050;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nuSQMenX/K36z+uq12eSp70AMhTM9Kpsrje6PFTIDvw=;
        b=1It2UELgDczdV/rGRmSZQMpyQoXD5cBANTYvtpin8FZsxf6qLS/F2zYcHOVBVwzgn9
         8SVXiRHKcEeCZa/BqRgewFZXU7KrAJ990yW4Nrg/BexuGSB5m0ruYMlDMubCxn8/mDE1
         asntwS71hPk9lZDa/+cAznPWa53DwvSPV921f5KRKbOQNaalcyQy4wMouj4Dtizjp/DY
         TXtbYaoIv+EyHtgZWN1VShlhZTRKq94Ff9gFsp5+QYpQMdjkWXIOOyWhNoV8+/BCg0qZ
         tzimlECnF/plXKLFKvbpxyiwD/TkFf1uthS7Dr+LU5yVf0vb/HOH1jAKOdUlQvedMnNL
         HWKw==
X-Forwarded-Encrypted: i=1; AKwUvBynN8K0A0M/3Xij+y1/4T9fY6EW4UquUQLt1Opn/jQHHvFv+JBOwcwrWiJ0RTeT7jQ082Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l0f6jSKzeCFL+I2llTh6gkQAbTWsbN2FESxmeNP/u+10Kxv9Go
	oFafCwmgLWpFBcIG7v8DoHbtZplj+6sFSuqKBaR+R2Y+GlgDPthyUi7ft+ncQqlra+2l2F3OEhO
	xrqmhrQ==
X-Received: from pgfd28-n1.prod.google.com ([2002:a05:6a02:655c:10b0:cc9:f7f0:57fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:3cd:9dea:2be1
 with SMTP id adf61e73a8af0-3e0d6582ee4mr757848637.0.1790975249880; Fri, 02
 Oct 2026 14:07:29 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:44 -0700
In-Reply-To: <ambEdSPjerZIVN0b@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ambEdSPjerZIVN0b@192.168.1.215>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097516574.4085525.16058159685238768229.b4-ty@b4>
Subject: Re: [PATCH v3] KVM: guest_memfd: Avoid deadlock in error_remove_folio()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 27 Jul 2026 10:37:41 +0800, Hao Zhang wrote:
> memory_failure() invokes ->error_remove_folio() while holding the
> poisoned folio lock.  KVM's guest_memfd callback then takes
> mapping->invalidate_lock for read before invalidating guest mappings.
> 
> This can deadlock with paths that hold mapping->invalidate_lock for write
> and then try to lock the same folio, e.g. truncation from MADV_REMOVE or
> FALLOC_FL_PUNCH_HOLE.  Because rwsems are fair, the problem is not limited
> to guest_memfd punch-hole: a pending writer can also block future readers,
> so ->error_remove_folio() must not block on the invalidate lock while
> holding the poisoned folio lock.
> 
> [...]

(finally) Applied to kvm-x86 coco, thanks!

[1/1] KVM: guest_memfd: Avoid deadlock in error_remove_folio()
      https://github.com/kvm-x86/linux/commit/ad06cf5338bc

--
https://github.com/kvm-x86/linux/tree/next
