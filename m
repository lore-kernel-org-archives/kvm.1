Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835540;
	b=lFKz/jZ0cj8wczeauNWU67/hwJIgz8fS1CdW+Fz0tVIQHf2RCwe2WhgcRA1niYEbCyMN
	 bkb+BGft9TXmzVIYQajkDSTFalV8gRMXDwgG2u5VOqocoV7v2He6a+LdzPRbS/uO6Wnr6
	 i7evgVS/IzWuVQRwcs5YWN2W0VPQQ7Cuy2qu55Iccs7lbV9TqGnkVodPB5ptsEVS/1IMg
	 ukIGJrvDJsrePzGUapZNGqVY+HxNNWxtMlpdal3BlGHDUPTndMpmdV/o2bBhy4PRgEP0I
	 NGW7XlvpgCYzvN7+D8nacqrR7807PwIjPbZ620eqv9aKAC7ndz4Njrj0rgtbfI8fTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fxeu//W7TMnbsao1M9RABBTEBmeABIO9AlVpmVOm/Ys=;
	b=WCyRN/wqmCQpRRpZmiq8KZSQTQBTrRzpSRuME5wKtHSOBLdUBBpxBvF4JHgPzQrUDsgK
	 wQwxyK2HmCJH7QkYFcDSxwBUxUVIFm9phhRVzxmnMPj9sdmNnQUlleskPCk3sZGcr/TfA
	 887p1UrxYKNeP6trhp5vtLJkbjQODF3woz2YdqDXE6evsRROJ8LVpsJb5706fc7BcDU44
	 JEWYj0l/m9/Hzz9/uLfvCURoqogbKDacXBLOwQP5Qf236ECEtreAcaGwUcvS9NQeJDcA1
	 ej+M8VGjxe13zQrG2+JtH793fl0gRL8R0rIjUtkfhvIkwAjPC5EqsZOQGwNgT3taMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4bF3ciS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B6606A31B;
	Wed,  4 Nov 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4bF3ciS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C9F1F000C1;
	Wed,  4 Nov 2026 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835539;
	bh=Fxeu//W7TMnbsao1M9RABBTEBmeABIO9AlVpmVOm/Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H4bF3ciSF488M1y+OMTI7oLl3O5ghxH45G/uud37F0B2HXW8pM+XFHXhJhox2NuNP
	 50TiyJdxWPL3nVEN550G7kkoEZ8H57aFGMXXVA8baJYE/8+9p2waX1/K/VEocoFrwi
	 GdHfkGeL3uWFuMYiSTnIzguOPraVdiczyPvu+1rrgKSM05nOZ45fB6F3VZkn+DV/W3
	 JOGdjyvSng0DwbAHi0XSaLsuPbf85ZllExHTmtPsAc7ySmk7JjGgtvdIfEjVKzvY+C
	 hOAsIYYR1e0WWTkwRYZ+eUC2fELFlV3WGAq2Lx1Tc9zJafR6TYFfeGYqW75t+9uOQ6
	 cU4GyTvu6Wvrg==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: add empty install and run_tests targets for unsupported ARCHs
Date: Wed,  4 Nov 2026 18:38:57 -0500
Message-ID: <20261104233857.966117-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auu5lcHexLy6pBe-@google.com>
References: <20261104193635.333141-1-sashal@kernel.org> <auu5lcHexLy6pBe-@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 03:02:45PM -0800, Sean Christopherson wrote:
> Deuling AIs?  The other patch seems like a superset.
>
> https://lore.kernel.org/all/20261014200152.1365147-1-sashal@kernel.org

Sorry, my mistake. Please take the October one and drop this.

This type of issue seems to happen everywhere in tools/, and I feel like
I'm in a giant game of whack-a-mole.

--
Thanks,
Sasha
