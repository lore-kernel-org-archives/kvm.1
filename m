Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431604C6EE9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593733; cv=none; b=Xs5ij53du9BlzK+YcOnRfcofh/deDrieoMA5uef4O22aKPBvsLzAwI5rp5moqc2SCbXAt0aOZhR4BRNuiIfJ4NQFcdSRGxP0TM9OopR4C/vGrX55TOWud9YRHXnf/CIt62MDHqIRWREZWOnJsLJEmJOoTGjUyB4vqlfSZIxVl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593733; c=relaxed/simple;
	bh=S4sKZCo1eYdfLybZhZ3xnLJlkWeMYBkj/leeh9Xc5xY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+zvS/52uE8KDPPHYI2tEophZlQtPeeKuQ63nJ627yenE99jEw3QCQfVRxd24sfiQ0JqPdSFGHXEqPgHbyIXz2JHMn9/uPRWktkW+A23gD2dnCx7hDaKtxQ7bKyzO2xJwJaCAX2kBIvNCI8DTQ+BBdkAqvC1rTLbKD7m2WbsN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPvtvOfT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPvtvOfT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f19558so630466a12.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780593730; x=1781198530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kybgd8JhXDdXVJb/Z58YivRoiAnqYlg6NRQiuitYUIY=;
        b=IPvtvOfT4OHBQtnXUjO4cFeA+OrXywCKuz6CN2kTIrSV9vcfVcAurb6jO40v9drkA+
         na5J+qUDfkM7WChZ1OrJNXN0Bv1InJo3MXukc5JqSFq8wrXb/XtAJwASW00ymxEmz6Rj
         MYHi5K2jI04v5zgeO0e/jLVSAumuy9WS8ksBfyJ32lDpRPab4+cxasUEXdbtqjG8bUvM
         ty7fu4Ft+IhNYwp1nZN8fRrxXxWQu/nCvN8nk4sUbpkaAoT10QI+1His6eIN+IJWLreh
         40oW2BBe8yiL8TRcU+8LRmlSj59TgCwm7wdpWkO97UajndyRSCryjMcEbND34YztW7Yw
         rAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593730; x=1781198530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kybgd8JhXDdXVJb/Z58YivRoiAnqYlg6NRQiuitYUIY=;
        b=RNhc8uiuu8vEn3EOKJlQBkrj8IvxU9cY+jJuWAPV7alkj3xemiFOm6qEu0j9G4U3Am
         mQSCqKNaDLcEPzTscg8ShQ8O8WVy7W8rT44qNhBdGcHScZBDZr54Eoc1uqLn5rccRsT9
         7Zqo9y4Sw1rJX1blr3MaN1P4LKrn5NCRUUHu5Ny06YGUZaCSQUttsunaEz+Ue5OMNpUA
         tNfF4uVXqiZIWXbhgwgTn+OCT7ESKHs18UAcRhHOSnlAs5Brd14wZU8dgDYS4035Tynm
         nS1oVb8aD5lNpSfQ9UhkukNvmjqIQHiVsllFxYISZuTH83pO+9ASVkJWOwZ6AGbvSXC9
         kNWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wBArCGmjlanLVWkD9ieZR5FcH4Q4/u2WK7epwaQSddpKqVNMK1O5VnQa6LKpRrKar4vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGO1aUtKx+Rqk1tiUNV9dJsXm0uXqWGwGzYFfr61UxAQs+dl7
	eU3lSDlM9KU7xA5Th12JDmYofulIY9TjZlxlCJTjUyevoRK3HVdG7iO6Lbfon14iaNgP5pe2rYN
	6iMJNOA==
X-Received: from pgmu18.prod.google.com ([2002:a63:2352:0:b0:c82:7c27:98c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f10:b0:3a2:d79c:416c
 with SMTP id adf61e73a8af0-3b4ccfd5bfamr53394637.32.1780593730104; Thu, 04
 Jun 2026 10:22:10 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:22:09 -0700
In-Reply-To: <20260604020143.748245-13-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-13-jrhilke@google.com>
Message-ID: <aiG0QbCdJNi0arD1@google.com>
Subject: Re: [PATCH v5 12/21] KVM: selftests: Verify interrupts are received
 after modifying IRQ routes in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

This is _very_ misleading.  The test _already_ verifies routing changes.  This
is specifically setting empty routing, to validate that KVM doesn't barf on a
complete teardown of routing.

On Thu, Jun 04, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-c' flag to tools/testing/selftests/kvm/irq_test.c to destroy

I feel quite strong that this need to be -e for "empty", not -c for "clear".
Because there are many different ways the test could "clear" routing, e.g. it
could nullify just the target IRQ's entry, set the entry to a suppress the IRQ,
etc.

> and recreate KVM's GSI routing table between interrupts. This ensures
> that KVM correctly handles dynamic updates to the interrupt routing
> table while interrupts are actively being signaled by assigned devices.
> 
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

SoB order is wrong (here and in several other patches).  It needs to be:

    Signed-off-by: David Matlack <dmatlack@google.com>
    Co-developed-by: Josh Hilke <jrhilke@google.com>
    Signed-off-by: Josh Hilke <jrhilke@google.com>

Please read Documentation/process/5.Posting.rst and
Documentation/process/submitting-patches.rst.
