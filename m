Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD43E7167
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838834; cv=none; b=HqyLyL8bKkmJKiM/3dXAKHvxbx4uv/pNuNrQnFfUfmY4hJDhB7LOERBwS5fmsvrfd8XrnsXQf2jm2eRmJb2YAYvXb7XjuiTf39L12HbfCr9zfnOlJeAxHTr5tc0JSu8ISlwt/uvFfRjAC4pljoy640PuqRqTq78sQBdq95rtIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838834; c=relaxed/simple;
	bh=MIy0cVHbfb3m460BkKV/HHfdrajWUPYwhwhBF4VgWG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hkOS4MCx4JTmXsUWP0Q4B+3PFejb7pZKjDqhN34/wXfXsWi2I/GKZq239rhQeuzq9kaeB05qL4TM2JZ4Z59LQtOqDB+bMLxNI7WZMVSfPHKR4B1ekploKjSG681rz7H/Vxk2XoupKCjvk70GO672eNVPEIZfJXhkYqgju6HVWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7rWYJsK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7rWYJsK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848860def2cso1205173b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784838824; x=1785443624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw/oMPXNQ0C5svpcPeCBdR9OoRbIlMVpDTMX8FwewrY=;
        b=L7rWYJsKP8XfnIXJQ0I5bdDVV+MUjvez8dIYIKcK+BEljP/cqZOJ8YSgg6422u5vvd
         jrhwd0aKTQErIMge2fNEntqZMqXMuDTEoJNEf1dqtx1jdx6qKOv+QQeJUYW9gqpHjDT5
         PWPEinWwrY9/SR79hYkHM7mEwyE+LgeJe7/xSeBiz3c6EvFaM9Zm8r/QO7EShpDnv1Av
         4aPzWd+LZdy3YQGCRE5VMu4KT14Uq/CahDNi8J1rqqNB2dlWp3kg+ojS5LLJ2VwGphZt
         qXZmfndZQuctg92BkamSiMdmba4jwORBH4UTEVGwqfCmWrl4NuDN0oe3bKCPLSuyZPUT
         CqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838824; x=1785443624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xw/oMPXNQ0C5svpcPeCBdR9OoRbIlMVpDTMX8FwewrY=;
        b=ngNuzhPC8uOP1fxz/GCqxiqaZY9KhuLbvUrOo3A6DzJ/bk8v5RTpeniWsaw7CWromW
         Ky5/+ppIhTp3ktrPuG9BqCihAaHE15cyGnLI+s/aM1baGR3ef3hbSwBWoISv/GTTPAGL
         y/eZUDawvvyNYynvQ9aBQoeCWCYHd+8Y5Jc+MOYyeUCwFVTGHeM1S7p0oOC5je/DtPtn
         qeJKCGiqvkIOh5aC/Ueljcza2Tj4zv/lqfv60spZH0f//a0ed3dkCzK5XOB7T0x1il9K
         WA0iURMZDCWJSHcdu6BLi6+Le2thjJTsK9MdSR/Fe3vFGR66iSc6+2FfP7/6uF70O7uT
         q42Q==
X-Forwarded-Encrypted: i=1; AHgh+RoCn8MEm/rfwToz0CJ+qcDbaVS9/YUXsShTwlcOG6+/Z1vYXlqWE+J+t3MIE13sK6kJDfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmB6BQ2V6e0oRA7Tgc6csoh3XHZy4QqAjAeNolviLkIEKDAhWg
	V+XZhuE6eDP+7/7J0D9X6NJwyG7eJvMnB3J8B6DbIhYNXerYmZqeSBVRPUeWczMlM/axdspsF8M
	RnYNtFQ==
X-Received: from pgbct6.prod.google.com ([2002:a05:6a02:2106:b0:cb5:f989:9b3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2a03:b0:848:5b1e:aec2
 with SMTP id d2e1a72fcca58-84e2bba3677mr5125027b3a.54.1784838823450; Thu, 23
 Jul 2026 13:33:43 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:33:42 -0700
In-Reply-To: <6c560199-1461-443a-b68e-e0297398c731@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-8-seanjc@google.com>
 <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com> <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
 <36036850-2d73-4c0f-84bc-64ba542ba425@intel.com> <al-dQ1EBD272HY4a@google.com>
 <6c560199-1461-443a-b68e-e0297398c731@intel.com>
Message-ID: <amJ6pnTqGepoM9Bt@google.com>
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, Xiaoyao Li wrote:
> On 7/22/2026 12:24 AM, Sean Christopherson wrote:
> > I.e. have this at the end of this prep work:
> > 
> > static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> > {
> > 	return kvm_arch_has_private_mem(kvm) &&
> > 	       !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
> > }
> 
> I'm wondering if we really need to check kvm_arch_has_private_mem() here. It
> looks checking GUEST_MEMFD_FLAG_INIT_SHARED is sufficient.

Ya, I came to the same conclusion and ended up dropping that line so that the
patch would be a guaranteed "No functional change intended".
