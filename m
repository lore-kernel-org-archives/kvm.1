Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353339;
	b=CYdT5kmzm35HTXCkwveAkrpPYAW5JsIstLh3BSdS7fpAMm0nZgLkVMS/a8oNRiBtTjhL
	 V6Fn+OenBU3uNg038kzewfZvZ7ADjdt2nxgel51+gGnDwxpDFRNWP5WuUrgx67g61tcwj
	 Fk6Dv3lVgkWN5WQkwD7iVMWOxxGYPtFxBX4BMyeLY6pGgumQH/jb8vHVEbIgh78jy1uAS
	 xxWVlNntgGeGB23/AXFvTKkvd6pfxbHEVLzMxvpPzAMWbm9U5TOt20nr/X6jadS6LoJ6X
	 Qpgmz33eXCobmGeBgX/DPhsh61pqWVV6D1pzE3O+exMOC1+7LtnCVDp1VBF3CcgFuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ynUwHadLmvdOhAgnzO1JkFQi8taE5cJ+NHtIgb7JTBE=;
	b=cyQoxMYj0ZfQUYmFaVhc+Wd1ObAvcDXfDc+4s3KJG/kwkYKHxYEeb130njY4ANYBJwRH
	 p7yc5bAPCAz5SEkF9zN0NefvzEVQDZkPbAwHvlzNiHef9JmWD9DVgjyUONqeWmWGFgINt
	 DiCMhPjI+IQrneZ62viSZDmujSslWO+7ysrRJi5Qywkf+K2Y4bv232LcLGMlGbu8hjlJ8
	 4TmR/WYICPTon/kTZNJwdvv/NAj2vCUcI2k6Mn4EK1+mu91MYoJBp3u0CWCl4mwP7+Wyp
	 1e2DDfE0iuPSUKW9pIrOzxXUOvHS6rrLkRjF+ReC05oeboMWIVDL8VVKzgvYbacvBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h07Ay6kK;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC83606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 23:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC83606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h07Ay6kK
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so2233031a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794353339; x=1794958139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynUwHadLmvdOhAgnzO1JkFQi8taE5cJ+NHtIgb7JTBE=;
        b=h07Ay6kKiqs/bNZ8GfvFs1KrZP6EFshDiQhOPI54SAezvPp49j9L97za2FiyBixRV+
         lYIJjWy6z2E4cCKYTaTv/aCTD/E6P/jvLsd7AdOIxb/ppaqFUna3uqwNlmPWgIEy99cj
         QihCA2v7WZk4xZAPazNr1YTx2967I71U8dlrsL4kcMgAxwmhkuPX14D0Tc32J4kvTnJV
         b6rwDhq6Qgd/2wNoBY220AW6JyETO2NO/UAvoL5kX4LD+MOEd7oBZLPrXVy4ERWqwIih
         XhCuueenyn4qYm73fv8wVEy/JSjDNRXoaOvGDxOQn/eR/hwGuJsnpB7Qzw/WTitqV8MM
         JbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353339; x=1794958139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynUwHadLmvdOhAgnzO1JkFQi8taE5cJ+NHtIgb7JTBE=;
        b=jeH3eEr1KBlYwhb72fF+eQWW+FHxv+znkYMtpHVckekXUSYjLows7WkUVEwiRt47PW
         /TyQUXct+YyaPSJy/9xWSNIy4dp1D9PPHkZQPqy/h+YCbunC+s+EnU3e7KIfDkF2VqN3
         PS8fNpI/VgPHRruwdpLH4A9/1mkVQkoOdeHkPALSe+x9bseEJ/XemKvCtLvvfkt70hc/
         NWfYicTLuVDSH1EigjHJlUaYXflhvF4ZLMrEPQzUOORm3d+98fLM1USuzxnz7lTnhLud
         iZTYGbQVjgDorTO0xrhakC1Lx3FexTKIUUmChnLkOfs5rZhMQxemfkIeCv1UXCdlYV0X
         ZvDA==
X-Forwarded-Encrypted: i=1; AL+hErHYJwSR9pc4MC9t8HP4NamA16E2kiyJE6u8kIeTBwQTSNrgy0kddl/nua5gCSZrzERhVnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RSgvlIdCjnfN1tOe7vQCDR81vCO6ilf/NGkwjKsIkblxCJFj2
	PTq6y+DmmO5eoNI7/eTEEQdPHZvVCT6hgg9hL5hi3rVFCk06RTuEPxcG3MVMWpTjvwIk0+2xzye
	MQN9RJQ==
X-Received: from plfu10.prod.google.com ([2002:a17:902:e5ca:b0:2ed:40f0:5f81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce02:b0:2df:4876:50d9
 with SMTP id d9443c01a7336-2edd76d1b3cmr7615645ad.18.1794353338477; Tue, 10
 Nov 2026 15:28:58 -0800 (PST)
Date: Tue, 10 Nov 2026 15:28:57 -0800
In-Reply-To: <20261105164531.313849-5-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105164531.313849-1-pbonzini@redhat.com> <20261105164531.313849-5-pbonzini@redhat.com>
Message-ID: <avOoucIBV59_ELE9@seanjc-mac.roam.internal>
Subject: Re: [PATCH 4/5] KVM: x86: allow handle_exit_irqoff to return EXIT_FASTPATH_*
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Paolo Bonzini wrote:
> Let handle_exit_irqoff() pass what it did to vcpu_enter_guest() and/or
> handle_exit().  This will be needed to trigger async page fault handling,
> and to suppress reflection of APF #PF exceptions, once vcpu->arch
> will no longer have a host_apf_flags field.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
