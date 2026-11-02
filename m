Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631530;
	b=tGP9aIoCtNATIL7EQje4V/3jyZZjKq44bNVqE+2WrVm9IIxS2y+1gnUNltWMaqZbPI3j
	 2BceDPI5/xOYDW3pXuUJ3ONKaoT3+ODEsua897Vj2ewdRZRfPwl82NgeC7redw26GyDuq
	 JRrsDZcaF4VpfXWv0aMo2bYtpUNe5AHLgxs3ZB7mYLQAmA3FQmSkTEN5wlXmHDegJOAc3
	 lIdkEOkdWYf4L9HfwzGFVNsPPDnpZ8rrhCPFq5p/sEcTi3c3hT7/2WVvCI+db4mK/szVt
	 2dk6fwdVdkMtv7QzwMtU0FLI1y5Wy+W7ptcOs4gq8rkxHInzUrC8GvR3tNp01GVtntQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
	b=sbUEN2FfRHih6au71JXXnnPOMulOX+91hAe2oADLzaUdkE7ApRDNvElkeNTSOw0Ak8GA
	 52tyAjErRTADq0W6c2yeO01pj0iX1rUKxaaGsp1I0nwOsWQoyxQCKS8edGzjr2DNvLqeZ
	 FnOCiAElCODF1vpo1G1GfAvW1lw4e2jp1DRLmAVJHgETdaISZQciS7nDRmmqyaH2lMgRG
	 zw6iqAz42tKGI2rfOwnL1acNFMlNR2y9662GFXSwEqeeFIYoKPxdHaI1xLyMBaRWTm3FM
	 E6nPK1JjHXSKca+omL4I0ntyJNhfWsiapwPI/JRxWBOHa5L+MBsxAVuXlbFPngIjIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TZywBXE3;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4648606C3D1
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 14:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4648606C3D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TZywBXE3
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9821ca96fso50484615ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 06:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793631529; x=1794236329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
        b=TZywBXE3oo1AuLBH7fBdMETQ/ZJUgYCO5nOgYZhMM2/RSWMHeOnBsVWpkN2kAt7KvD
         74dzAt9PIPbwp/6+RUsGUMXtWVUoMV3MdAigrrJIZiU/oT21l+cUq8atuQ+RAalmSlHk
         g3RJ7DyQkTdkIAvVBxgZUe0Sz810/Xb582RtJwJCvscY3ni5bJfSTeCbvv+C4vp62UV3
         an0957++A+LpFnNFNacx9MYI7lnZMrH8MOcXyiWyZ5j8n9FueDIB/nvRaAJodCsoUOg1
         oMXcKKC21ctT7VDibGCwQcUAZ00IKICYtJZusuhXMeMnt4qTZRFqLClfq3HFOkmznWQ7
         q4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631529; x=1794236329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGZaLVl/bf+VQNDSvC9YaFRzMNQ+JkOw52QT0TU0FxI=;
        b=xBPE/IMq52ILCwdmT3NwR+f0krf9VOyOFjYdGOtdmf6br8o+xUoTyE2iB8C+ANaBTn
         l57vU2WDlx5kmqo11xtiXs19Y1to8gkznZ51ieuNrL2VspldrUcql+R0NtVJKYMFNC5N
         A7qi4XmUw0eDngB4TJBE0RNpMI6bLhh8c1PRsR5OVLu4T8GdECWUJ0teSW4RcxUC8dzK
         X0UFg5S3OAOsq9tLvZESyz7vxYefJZRnPhv90/fP5wUqCD/+O/40rxhoXBDchi3PQQRS
         094P7JVop6cN0aoNsj4+7iPa0fh/u1YbJ8Pf7T5OAHdnCu1ElM65Y7UJPeoooc2cbO0G
         oUtg==
X-Forwarded-Encrypted: i=1; AKwUvBwz+sdyuIReoTj6nqvqe+R7e3Hg+iGlQJK3R2DX9N6YQ+kvlJlp5T4URzoy/uUWyS/sfCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/CLBl09EX7BK6vDcKk/2PZkteWjnURfQHYLHWIPx1PAAtFfFZ
	QAD3t7zH70YxaXupY4xrUgUnbwdH7VNjIpqoHpY7V0q6E4aWhxKAySZptyWsQMwk0idWcajqsbv
	83IhS8A==
X-Received: from plnl5.prod.google.com ([2002:a17:902:fd85:b0:2ea:44fa:2c44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f691:b0:2e2:d39f:182f
 with SMTP id d9443c01a7336-2eb3643d489mr99134825ad.28.1793631529137; Mon, 02
 Nov 2026 06:58:49 -0800 (PST)
Date: Mon, 2 Nov 2026 06:58:48 -0800
In-Reply-To: <20261102074657.27715-1-jtornosm@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029165845.GQ1685504@ziepe.ca> <20261102074657.27715-1-jtornosm@redhat.com>
Message-ID: <auilKFwKLjw-BnZM@google.com>
Subject: Re: [PATCH v3 2/8] KVM: add PCI MSI hypercall for VFIO passthrough
From: Sean Christopherson <seanjc@google.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: jgg@ziepe.ca, alex@shazbot.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, bhelgaas@google.com, jjohnson@kernel.org, 
	johannes@sipsolutions.net, kevin.tian@intel.com, kvm@vger.kernel.org, 
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, pbonzini@redhat.com, robh@kernel.org, 
	vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Jose Ignacio Tornos Martinez wrote:
> > I probably would not have selected this, it is why I suggested
> > virtio-msi or something that could be optional and seperate from the
> > core KVM guest ABI.
> >
> > But maybe there is interest in doing it this way?
> 
> Since there was no feedback from KVM maintainers,

NAK to adding any KVM-handled hypercall, and probably NAK to any approach that
requires KVM changes.

With regard to timing, please show a little patience and awareness.  It's Monday.
You posted a fairly large series on a Thursday, during a merge window.  If you
change direction after ~2 days for a series of this natures (touchs multiple
subsystems and introduces guest/host ABI), you're likely going to end up with
severe whiplash.
