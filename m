Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25133EB17
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305220; cv=none; b=UJ8AknRVC51xhNrLTQ4wQqM918rbLTH8JDycXUomMtQkl1P76P0gRjcZMdePQOVscSuqOSesqTxsN7KFYaLA45yu4/cmvHt6Rtee7EbvcZ7PpNFIpaIXqTJw7wTYhVTa7hpkksRrOfD+QHe01uYKfvuW9SLHqtue2sT4Mi7ZoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305220; c=relaxed/simple;
	bh=XvPLC2O1lqhgPdjhRBgX3VePjbJ0w1QWfcgogcRU5CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBAMthwfXMfnVfZA0XHdxBIARksFMMgvOzvsHzX5jMlwUu3ClLpxSYA2pR6yu4Lte8l3maLl3T7teVYjFlM63MvNHgXkJbpGYlfZd066CNVM7AmkapG0xaJgYiXeJ76txFLtVjql7tZCTwN3+m34J9UnIhies4IGgah456+zWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SAeDyE/+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SAeDyE/+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954df200ddso1927135e9.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784305217; x=1784910017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hJac4qKltuegfx9t2fMamL+c68Ol15fvhuIJm9Eo7Ao=;
        b=SAeDyE/+5PwS+mOKagKGkOpb6k2+5J690Rh1mExzaehJ1eSleNwBIQ5aEXv9mwNdgd
         Q6J+oI/fsnLfv2Q4LjvO2tyCA3diHjCGwhsMhtZHENJ1tQdhYtQYEUObTf1TYTlfPdRc
         PJzy720YSlSJKug9Xk2XBuisgKPNdUPb4d8Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305217; x=1784910017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJac4qKltuegfx9t2fMamL+c68Ol15fvhuIJm9Eo7Ao=;
        b=l+uMIF7vAbU0SCu9m4B+JqiONNF9gAaTKPdvibY6T/cU+6pwes3jbC9hihk74g7jBD
         xePcyn3Fee+X2S6vAz6emow4ZoIQhg5y27KwAqX1urwBXWxJXMlpkkxvecJXZX7OUrXF
         g8LWJemZ2OVmxGnPk1spZXnLWI0FHk1GNGK36lQ58V1+Rndw8xFIxgwMaL+EKiLqUIMi
         V1nIGmvpHbJXnSAs/DsX8CzjnzXyAHvTlP2KRwYC9vnuD45CWjzAkPGC8lGcDnFyBdj4
         yMzNmX5LB20pvpQIF33fK3P8urYw+JmCGEciJV5GN/zFyJC8OrtpZELuBAN1wR+/yCD6
         1u7w==
X-Forwarded-Encrypted: i=1; AHgh+RoNqIsOD/Y6lEK7dLU1BHNC3g2ARGvKncHok0qBLiDNoL0L54Nf5Xbg2bFgeJpDNHYiqOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE550Hn9ZjPssrqXFVaR3lHYFXv7uhtH3kglpvM3mDbboO22Hx
	krROC2cLZMa6AFcPMad8todPCh+HLOhXp/QhtGacrAQTZ1nWcLQZAAzWJMTjqTYMng==
X-Gm-Gg: AfdE7clT0DRS5WftEOAb52Z6usNPocr4nWItAz4vPzWjrZxk6UUOlRM36OnxXjnzsvP
	rvosMEel+9Dqv+SbPBoSQgrrS12/EXxY0PGpYrqr8HWDeRipsxYqEJlMmBFzIsxMiZViEO6vdm4
	GIam75GlPcq+VucIVDQgoA3se1AhIcqC8O8l/vgn8GNooNnZNFyZda4MSEo93SKiGOPmPQwGWT/
	5xVwnGFAry6pQtWd73EVO/UKncZ7dcdbxqwBl11j1sBoUNWbzYz6rAEhJuA9zG2MPPXZltSECcB
	rh/ns3aygFKq8gjCfeTKDNeSmCzDjXO0ygvYsLzA1k48I3iPB4P/vd+5tUkzsvDAr2EQ7gp8yqn
	DGLjtRC4SnHSCBFCu+3aNK7mMbQocTH6hMdhIBxXPK5kfKvkU/xq/73hyQvRbWniWFoPtX4y6CL
	TcOri6T7+CAQnpEyJckYXlHQZqJdH9Nl/l1foc6siD/GWyGOE=
X-Received: by 2002:a05:600c:1396:b0:493:b150:c607 with SMTP id 5b1f17b1804b1-4954a3f36a9mr38930265e9.12.1784305217170;
        Fri, 17 Jul 2026 09:20:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:285b:8:8588:dee1:8c51:ece3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm2345117f8f.21.2026.07.17.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:20:16 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:20:09 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"aashish@aashishsharma.net" <aashish@aashishsharma.net>,
	"guang.zeng@intel.com" <guang.zeng@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaszczyk@chromium.org" <jaszczyk@chromium.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Message-ID: <alpWONLi8h2T5WhZ@google.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>

On Fri, Jul 17, 2026 at 12:59:38PM +0000, Huang, Kai wrote:
> > 
> > An easy fix would be to clear the pid_table entry in vmx_vcpu_free().
> > However that would be still problematic, for the following reason:
> > userspace may try to create a vCPU with the same vcpu_id as an existing
> > one; vmx_vcpu_create() will succeed, and only after that
> > kvm_vm_ioctl_create_vcpu() will check for the duplicate vcpu_id and
> > fail with -EEXIST and then free the vCPU in the failure path. So in this
> > failure path, vmx_vcpu_free() would clear the pid_table entry for that
> > already existing good vCPU, i.e. effectively disable IPIv for that vCPU.
> 
> IMHO this seems a bit fragile?  If something similar to pid_table coming up in
> the future, we could end up with a similar problem.
> 
> The "duplicated vcpu_id check" seems the ones that should happen as early as
> possible.  Is it better to move the "duplicated vcpu_id check" earlier before
> vmx_vcpu_create(), e.g., even before the kvm_arch_vcpu_precreate()?  In this
> case we can do the pid_table cleanup in vmx_vcpu_free() I think.

Unfortunately it is not that simple. As I understand, the reason why the
"duplicated vcpu_id check" is done later is that it needs to be done
atomically together with inserting the vCPU into kvm->vcpu_array after
it, i.e. both the check and the insertion need to be done with kvm->lock
held (rather than releasing kvm->lock and taking it again between the
two operations).

IOW, if we just move the "duplicated vcpu_id check" earlier (before the
first unlock of kvm->lock), we have a race:

1. vCPU A is being created but not installed in kvm->vcpu_array yet.
2. vCPU B with the same vcpu_id is being created. It passes the
   duplicated vcpu_id check, since the check doesn't find vCPU A in
   kvm->vcpu_array.
3. vCPU A is installed in kvm->vcpu_array, vCPU creation succeeds.
4. vCPU B with the same vcpu_id is installed in kvm->vcpu_array, vCPU
   creation succeeds.

And we cannot just move the kvm->vcpu_array insertion earlier (before
the first unlock of kvm->lock), at least because the vCPU is not even
allocated at that point.

I guess we could track the used vcpu_ids separately in another xarray
(or a bitmap) which could be checked and updated by the early
"duplicated vcpu_id check" before the first unlock of kvm->lock. But do
we want to pay the memory price for that?
