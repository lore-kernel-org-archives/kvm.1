Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964543ACA5D
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600674; cv=none; b=V2RFHtD/7C8+epakbvhVzqGMJ2RuEfVy1srS8g7ts1v4mpINOhIjtk8dsVd790oObYPRD5fTYEQic2fZs7ETgk6eHtDIuvbl4pF4TsMFkSA1zjRbs2+y6zVnGMUS337IGD9aW7Q39iYG7EAO4q0BIuf0a3e0Z+TEneUouom1glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600674; c=relaxed/simple;
	bh=Mrl9k2OYxCttpt0oaJBvFcDv/awuA7xGxUf0yffgjFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buYaKiXLkPHchyITkPIus2qcirlFEfVlZjHsF7epb+xNvMh+LA+YsAJrW/U7B1eyk4wtbEqvAUQ90qlQoFo6XVrQX1YHUX6JiaKUvpXg3WBz9w2ip/fE6yw2MWDO0yHYkMAEGZN4ybfpIn+aHUNrAD/V4HqQJvyn2XPDm0VsSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5r8olKb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5r8olKb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so2598405e9.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786600671; x=1787205471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+7PeLXe+ue8rItbBi6+JlGfhsV/36WDiPAKPGI7m+do=;
        b=Y5r8olKbQA4KmcW9MwLfY1sP4HOfESCCn2SatRrFA1havzjn0jngfHP5fQr+C0cUyG
         fTw0KXazOJ/aIWTvGZrcSno+nEZYHc6nPo1dPcOgL9YSixO6mslcCv0kUUkP+0l5o8CP
         ZXzKp1GQ9ztiLIIAl1MNiLrcukdAk6UsKM6ziWifIzBFTPYnbUdxfzMYowI6cXBbOgDq
         3hMccu51xyUq6krsQ1N1jxgU/eGuNjm7yai5L9fy2tdTvgdlex6VAQ3rz2trW7TZmYCA
         r8NEtB3BBC0y1MW3r2OSGnroBwfSCih2ThnoroyJ2prTNj8hiVMI0sifs/YiREQ/8NEG
         Eu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786600671; x=1787205471;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7PeLXe+ue8rItbBi6+JlGfhsV/36WDiPAKPGI7m+do=;
        b=MpZv82AJrLpcicCiANu3r1DG8V3R0NBQ4yQCTN4gxxA0lcAEbaymx5spvmOXjm1hNG
         PXdBC1opvRi/JBaS4UkH7MGCv0TLSx96hM7xH4lWq9sIMpvWqxZWVjYkjshYrvMVRMIw
         tUPf4CXzvjC/xTKIywPUyByt3Ow3SChGviNYgMZ3RN9Le0LkORVzLJ9n0XsiRriphzhl
         QYf3vJBA7hIc6njCoTGGuyLJaX3gnDv7iQZtavypfxd8D3Hl4wNh21qvb5w7jrMdHkQl
         oZq4hOyOtKIl+M3+zILu+Ao2kdY3Vng88g55uufeKwcfShFa3Riordht2MfE8BV7Gfgo
         obow==
X-Forwarded-Encrypted: i=1; AHgh+RqA3H48wU4qDpunTn2KPtKr8KP7sB8AdCt89KpjhSe5/7/cJuHOAu5KE7vAgqGcE6cq1t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIthoIwx9AhDlEgs3pYZk4vn1kH13I2AO1W+lOC1B08b4qx87j
	Ri++PFDjIrVSrTIvX9WEbKvdQ2ZfzfAky9dX5UPMs7L6SEixNAfBCdh7
X-Gm-Gg: AR+sD13ERp7O5EQKRSB7fYuRdo6kP+TJY9nVJ5mTRyt0pe2WKleUoef9ri3JeRYhNwC
	qQsTLXZ8egC/PfG34MCzkDZgUXNC0lNXd99WvZXECn9ylGdMEaMfhtg/pyiP9Ku3YOX9C/94mAn
	2hAxSj0KOvXkFgoG9udH2uJgokhK0Q8iU6JwAsm0bznEqKetPsnGK1DEbnrtj1Ypg3siOYaYca/
	V/UDbYk5aF+qvIpOmNv8lTbvLM10JxumaOzqKBkN7h+ZRKrFnB8qNYfP3ljzZfBHkKviyJYfQ4K
	FwRHTZ5n8H8b8anBtYIMIcQ2rIVWJrdBYxYGS2ruBaedy+osvE28Fz8GlxMPCGY5BL44n/pYw6l
	uFtem9BZgRkJco/eS9atxp5lUoQQi2uUfoDcTMZ0R/WPjbrBIdLjCZRaRZjUO/08S81YsBZeqtm
	EikFTAdNbidetwUcsK0qHuzBGPdpPdt4zcRjh2Gkpttaaq2X5WdA9AvHZv6dQuS/kVIoBaKTRLS
	7lhirRM9K/3ybjvP+VfkriKWa4od2GN65ZT3NtWhQBRgmIR5qqVKDPYgIh9ZxwaoAIuqptvHCnF
	hk7fO6YiQwaVav51L++1wUNGCsbTzj0nnbX9PJ5ZUNEFmjO4r8OKyO8GluDtl2l2tpQ=
X-Received: by 2002:a05:600c:190f:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-4998218e63dmr29591735e9.14.1786600670592;
        Wed, 12 Aug 2026 22:57:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-9c79-1f01-1565-573d-10dc-99f9.310.pool.telefonica.de. [2a02:3100:9c79:1f01:1565:573d:10dc:99f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998216cf70sm28991305e9.12.2026.08.12.22.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:57:49 -0700 (PDT)
Date: Thu, 13 Aug 2026 07:57:48 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Eric Auger <eric.auger@redhat.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] KVM: arm64: vgic-v3: Roll back failed
 redistributor region setup
Message-ID: <an1cYl928Fue-z3s@gmail.com>
References: <cover.1786344511.git.kmehltretter@gmail.com>
 <4e00fc25aa61ec52e6ef033a53588ce3f5550982.1786344511.git.kmehltretter@gmail.com>
 <86tsp2139b.wl-maz@kernel.org>
 <anotFcOP0kcQJwrA@gmail.com>
 <86jypv1lxo.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86jypv1lxo.wl-maz@kernel.org>

On Wed, Aug 12, 2026 at 02:57:07PM +0100, Marc Zyngier wrote:
> On Mon, 10 Aug 2026 22:22:37 +0100,
> Karl Mehltretter <kmehltretter@gmail.com> wrote:
> > Is this closer to what you had in mind?
> 
> No. I want *all* RDs to be gone on failure, and the next successful
> registration to result in all possible RDs to be matched against a
> vcpu if there are enough of them. Effectively an atomic behaviour from
> the PoV of userspace.
> 
> See the patch below for what I came up with.
> 

Understood. I believe your sketch needs two small adjustments:

free_index must be incremented before kvm_io_bus_register_dev().
If registration fails, the current vCPU already has an RD assignment, but
there is otherwise no increment for the teardown path to undo.

The garbage collection in vgic_v3_free_redist_region() should remain.
VM teardown frees the regions before unregistering the RD iodevs, so
removing it would leave rdreg pointers referring to freed regions.

Does that look OK to you? If so, I could include both in v2.
I'll also split the selftest change and have it check only the
final state after the retry.

Thanks,
Karl
