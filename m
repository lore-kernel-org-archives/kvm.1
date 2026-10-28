Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192961;
	b=ApJDNb7c7dnEDN/ZGGFAov/ImoCT/uG8dLRbKWnsCRtnxhF4j6vnd1G6RKF8u0ea5X5W
	 tbnk8xQdn0kTLGSjA9vKBCdQuIobJWGbgbGO2lcChy7tnZdoVck/GUvjxZzazJdqMilIK
	 nmxqXlcodbZy/9z83Et+LI8zO/QB8LdMWx5obdGMA3STD0QOu6f2TPcNNzFyg6/SJ2xY+
	 ePdk3L7ppjURsWgVi/abbfk0LS1PIWVKxjLRPIgzFoLsJifaRbMqjmDy9/4LPq76kKzx8
	 48m5NMytn3Y3dQQ21mpUVfe+Mq2HyeBu5HQfUJ5z9kT6qdEZZ5g0I14P/PuUUWnccPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192961;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=GQnN8e858FaeeR7NeCLyREatS2xPiw/Xdj2+DbU65Ko=;
	b=YM80x+h/R+p4axOsl8IruNj2EIGVllU7nv2zRoFzX5merx5NkKRRLQOjTnLCgDKjXk6D
	 RziKOeszPT+stp2EgBiyF8eNDX52OyS432AY2j3/4v5aQAPjqAdwAR+nrjOIhEK82axZb
	 SNKfI9a+y0jTTspwoFo/QSASNFDFpUXQnwse1eIKcO4ZLqJqO/LGvuuXyjja9WL/JHZZh
	 YcxWsl0H7u0tEuuNkgDEQsrADMB1AV2cEmcMft+nvsvrztAe7VEyvP7jQBHtiobB0RIPm
	 +nWVHFmq0EWR0T4BL1+9vTXdYNve9TNE6NRVZZPTo9tKv6hIFVSrIwfAB11qIefRg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OtoAHPuo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22F606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B22F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OtoAHPuo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793192959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQnN8e858FaeeR7NeCLyREatS2xPiw/Xdj2+DbU65Ko=;
	b=OtoAHPuoAcjx08Zjqpql3TXr6SWlbxnN6gdznUQslB9ZO/w+sR5uxasMpH9i1UcyEjLbfp
	5KGxzt9xErmf4bX5jkfeVlED0l6c7ytq9vKljQOkvziVEbHDeT3mTEC/oUB+UWgaqv8bN9
	wQuCMRPBaCa105AH3Cu/gCOWL6aHr+A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-IuFlwiz2PhiNhohUM5mRbg-1; Wed,
 28 Oct 2026 09:09:14 -0400
X-MC-Unique: IuFlwiz2PhiNhohUM5mRbg-1
X-Mimecast-MFC-AGG-ID: IuFlwiz2PhiNhohUM5mRbg_1793192953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1749A1953971;
	Wed, 28 Oct 2026 13:09:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3C561956089;
	Wed, 28 Oct 2026 13:09:12 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:09:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
	John Levon <john.levon@nutanix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2] KVM: optionally post write on ioeventfd write
Message-ID: <20261028130911.GC1217203@shajnocz.csb>
References: <arK05GrLtiBvbfmm@google.com>
 <20261027180903.1008-1-thanos.makatos@nutanix.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027180903.1008-1-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 27, 2026 at 06:09:30PM +0000, Thanos Makatos wrote:
> @@ -811,8 +819,36 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this, gpa_t addr,
>  	if (!ioeventfd_in_range(p, addr, len, val))
>  		return -EOPNOTSUPP;
>  
> +	if (p->post_addr) {
> +		u64 _val = ioeventfd_get_val(val, len, unsupported_len);
> +		int r;
> +
> +		switch (len) {
> +		case 1:
> +			r = put_user(_val, (u8 __user *)p->post_addr);
> +			break;
> +		case 2:
> +			r = put_user(_val, (u16 __user *)p->post_addr);
> +			break;
> +		case 4:
> +			r = put_user(_val, (u32 __user *)p->post_addr);
> +			break;
> +		case 8:
> +			r = put_user(_val, (u64 __user *)p->post_addr);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			r = 0;
> +			break;

goto unsupported_len instead of handling an unsupported length
differently here?

