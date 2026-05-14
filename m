Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADC33F5B2
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786026; cv=none; b=nnZHXgSxB/su4DsLWWinhyfnRZrCiuQSdYNbWyf/CxxkmXVSv69mMOuitu5gePktWfniptkqWphkyNYDHRJSil6CXlEUirFRHxWX0hdQX+RBMqpxyLodJbn0gViVTDWy8/Ue9IN27/irSWFYCEAYzwirccGPivLKLWUin+i49vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786026; c=relaxed/simple;
	bh=g6E1YhgFIAKekUJ8M+kX+uFnBQrrg6Vntp1oWoiMfJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uS9CxoqJc1Vd02L+T4TK8QIHqd1oNFtj6D0sBwoeU6agSMoE25WR4WlTWsI+wW0JlLs730PDBm+2qgoqt8eQ1BAO5f4PW2SjpcvIj4+pSftbjg7tjppiGEl9PRUIeqR2aQL075u2o0hSV4fD6rjZkdXPME44dOhlsFXXLmsAZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQP9su5F; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQP9su5F"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba15e384c7so52391435ad.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778786024; x=1779390824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMyGR5JrSYEsfnzlUaV8QpwcRL3mwnjlOqpMeMLy0Sg=;
        b=jQP9su5FOVJ5L2Tg1Nj3ppEZ3llkX7r6LMBz000i5Tnt9s5bmazbE7GHaMgQzRMhfx
         XU9aGmPDL8Jdf7BOEEtW7p8jy5cv5QN78QjbpuGK+ELXRvETfM+I38jxhsQiM3jDw5xT
         SEABxDmuv+99mGhyax7u74f6QpfEn3d2AgnS0DuIeGi2emmRVHlYZW+u5Gto01V4Ihya
         tUpZ2Oe2XWWPuCKTdxlr8d8VrXV5uPKje7BwHu/mnpAShv6atawuzf5MU+Srm6pi/irT
         UtAZDWiXXgKiZ3LGtNENoAv5wW7JZWgvZtvMcRnRGjsPqlR8sVasYmeMgDQJ8xC6rtfi
         wkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786024; x=1779390824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMyGR5JrSYEsfnzlUaV8QpwcRL3mwnjlOqpMeMLy0Sg=;
        b=Hapy3mZV7G7IlT82D4jaSCetbOYYlypxy6M7KjkerMKRE833jkyWT/cZWnSjmCqDVn
         LJe3qZsEPlRM87mekZs2Kp8a8XzWDon690vy9j8Kgf2MQjz/vfDXiQvlt7oU7p34oTx1
         wywikHhlh4rjRYmdqvNveUdO631ZrLWP1QH0vhGn5KP6FVww45RxdQyHn4gStxRyfegj
         /eYUzYYlSfnwDRrA3FNM0OceaAD8dWCDtn0yqOJqPXEg18nKvTYOJ+di1CEVngsVLDdy
         IY+VkCN3AE2csnhRtTqVdCvVw/7nDWJkXLq3UPW06fDPZMKzYbfdNUhYPERotUagsVVP
         hAfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RR6IgriQFgD/SyxsAj8a2xaSBj2D3RkJHz7oCKMpPbo4HPxFpBPBeWTedlWX03HVcRRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gwB+86wJahy7+nWciT0aGwTg/L31jkbiW3RwnWJhLndPcV2j
	wPLCXmbhTSsJlNFw2NcAxnOplSwq2rXiWTJ9YnJv+cKph+Kb5r3cd75d/tP+ydMymBeUkLn52qb
	HnlBwAw==
X-Received: from plhn7.prod.google.com ([2002:a17:903:1107:b0:2ba:a2d2:2a2a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c4:b0:2b9:e82f:bfef
 with SMTP id d9443c01a7336-2bd7e88f2d7mr8251685ad.21.1778786024022; Thu, 14
 May 2026 12:13:44 -0700 (PDT)
Date: Thu, 14 May 2026 12:13:43 -0700
In-Reply-To: <agUvVorKYNmGx3XT@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <251c6f2c-6a6b-4a7b-b0d6-330611bb12c6@redhat.com> <8ebbfb3d-69a0-42d0-83cd-78e163e3acdf@proxmox.com>
 <agUvVorKYNmGx3XT@intel.com>
Message-ID: <agYe55tMcLRoMT_1@google.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: David Riley <d.riley@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 14, 2026, Chao Gao wrote:
> On Mon, May 11, 2026 at 01:07:33PM +0200, David Riley wrote:
> >is that enough?
> >
> >dmesg | grep -A 50 "soft lockup - CPU#11"
> 
> Do you also have a hard lockup trace?
> 
> I want to make sure the host lockup is not the issue discussed here:
> 
> https://lore.kernel.org/kvm/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com

Ugh, if it is the hrtimer issue, I apologize in advance.  Despite being bitten
by that bug over, and over, and over, I somehow keep forgetting to mention it to
others when they run into problems.  Glad someone is paying attention...
