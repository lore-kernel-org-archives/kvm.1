Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748815;
	b=Ip93OtxYQfajY7PyqkUbOjv8VOKqqA9Ts/XumJMmc/+/eFlQky+GsbChPJRrbSlt8dM4
	 nhAT/0jGmjVWLkU1rNBxl2+5Q6xHX9UKA+M3hkxsvNGk2Q6U96JmfYji5kLBudEdtglds
	 9ZxcAag1oJfGbrxTUsrQGKFDxcuec7e8MogSNT9R82r43Ury4tjE5+8ltyvN+/bt50yWm
	 dFBUk7y+14/coKSJpkXMmOHCiDotLw/s+H1h3XThHbhvfJlMZ/IIB/80vac6L3qOGi9yR
	 2AvEW+F3Mw4We1eknOXQ5NLxTib3TC64uw4xniDpmkzKI31DDb1W7SjEGRmJ88+vKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748815;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=Wq295VF/l3nVdW4ztWaaG2x5EbbqnZRawyUiM4tskWI=;
	b=V3Xfzt83JKx2rj0Cbc9LMkNjBpbUG/7DiYDlY7qg8tp2yFp427Q306FEC4edS37BlVrj
	 1+U1KntUd3DpXgKzz70MewocpBqnglYgJve2HRmVCGRE3YtY2lqbhRd0lpRJiXFGRIul+
	 XSQw7Xgpm7SoZFTm3oHaEkD/LGWlKVvf6MWcEObLpEnOJUgu4rfmreGfxKRvYodE3q0QO
	 Fk3ZFgxuS33cIYpTN2bKMwJYfgNTTA2DFNsZIvjCJw5M3haxd7hr6bOSmaJt1IuXU9pfZ
	 OiogJjwipk0iTac6/ikrQyIHf78bgp4JJrz50Y/7LUosCNWvDniPH7OUKxZ9XH6yLPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=ma.08@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NbEUfj4s;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24944606A31B;
	Tue,  3 Nov 2026 23:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24944606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=ma.08@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NbEUfj4s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793748805; x=1794353605; i=ma.08@web.de;
	bh=Wq295VF/l3nVdW4ztWaaG2x5EbbqnZRawyUiM4tskWI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NbEUfj4sSLI2d79l5BdF6InBaUbOGfABfDVotE5mKR0kltAoTkx2fMy+fokteIoE
	 YFNLbdItT/72LFp9HK4UZPmflE6FDZv+dOADluzNJ6snYP7pmDSHLQG6eYCp6X2uZ
	 H3qbVfdfUKSmd2WNquEJK/mY9y2g0+Gq6iyx2zHBB1asNj+D2OCMufL3LyA62T8GJ
	 ETMvIDWHilUSQvlGuOlufXZeLdVB2q7GDu9CcHxdfNBA9mbVl/rG8hRZPGUv5IM53
	 6OBrQ0hghcfSCJ3mQN6pUhJeOlgfFN4snBtnH4tJjwZ3ImIiF9SUaFs5+QqLZ+BDf
	 CHPRwN2fxNA+hzQm8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1xUAlc1hh7-006FYO; Wed, 04
 Nov 2026 00:33:25 +0100
From: Abdelali Maddane <ma.08@web.de>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelali Maddane <ma.08@web.de>
Subject: Re: [PATCH] KVM: nSVM: Validate L1 host save state restored on RSM from SMM
Date: Wed,  4 Nov 2026 00:33:22 +0100
Message-ID: <20261103233322.9154-1-ma.08@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103230750.1843-1-ma.08@web.de>
References: <20261103230750.1843-1-ma.08@web.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y0TxBnzSNqey0En1Ib612Q13ImbA6IqcsV+7IPSW9ZoGYASBXDd
 UKBFAftKCIpWwfKcgNNONS89RwsGDmZYoRfqn6SGH/YlPmzOeXXS6s7gkegRcowHcprIhsg
 CAoirshmZNtkB3aoqYOzLmy3xJE47lLgt3oVj3TLtD5oDfQtPJOOkvhZsbzaJvrjGJt3XWe
 8YsNPxH0PNVydQ266yB6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WhDIAOneEVs=;bFqxl7T/8OXk468Yf2T9DX8JaA6
 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
 jI=

Please disregard this patch, the same issue is already fixed by Sean's
"[PATCH 1/7] KVM: nSVM: Check validity of vmcs01 save area copied from
SMRAM on RSM" [1],
which I missed before sending. Sorry for the noise.

[1] https://lore.kernel.org/kvm/20261102231428.13523-1-pbonzini@redhat.com/

Thanks,
Abdelali
