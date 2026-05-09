Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8E42050;
	Sat,  9 May 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330842; cv=none; b=pcIrR6DDv79tf7sdb1hQH5BIltxRm74FtaKNuiU/NBLz8sOtA/MA/3B0Ipddjxh4Q4lfIegGU09Td1NeemDvzLL8R2IUxiIU9g/aXT/CDI2vs7JM4mQey6GZ6VAkp+1JsMBpRInpFBc1rWLkCXe8Xf/lEDGf3NmRQdqV9Q+onMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330842; c=relaxed/simple;
	bh=4Uumjg4BRtD7VZgnBuOSbYCMVld4xJ0lLi42mdWqFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSLbHqhJOAI57w4sRCMRgWLTx22mZVJSc7oBTZfSRAEiJoK0oS+4mnIjkfpPO8614Ias/Drhr1k/aHZ4q1DT/FjU19C717hAkHDONe+1Oh2P0KW6VUQiloFbu+DTsqybkZuhXelj8pzcojGUH4WPc6c/9a54cW0e4zCQbFcMd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rupBJx/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rupBJx/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09631C2BCB2;
	Sat,  9 May 2026 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330841;
	bh=4Uumjg4BRtD7VZgnBuOSbYCMVld4xJ0lLi42mdWqFe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rupBJx/MTPK477D7X+jHqyTfUv0mkJmn7dWAdsJs83uJykH2u0fai1My3MReqUpX4
	 sooZQQVpoUHoRW3+3gKWj9qQQmGJJg5eXWDoT0yr9z2B9aJYiwulS1XG9DKP2wAbUZ
	 XW2MGsw41o75Dz8rD5t3OjDwXzlZ8j3FkjwwMbWft+YzEkQQVqo0rc4vm3Px4mCA/6
	 yNYESb4aRGt1oeVan63grBDF0XdJbjD3fEQfFsmu1G7cGMXF95oh92PruCPOQuCAn2
	 l32gA1GEkFhj2r3mfvaqCSl/6vjWjxd+qeYfIeNitjMn9LCOzVF84bhWeMMlTxtTiP
	 jdfIIwIncbtfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:46 -0400
Message-ID: <20260509122858.b326a45a6af4.re-kvm-x86-shadow-paging-uaf-7.0@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505065715.186759-1-pbonzini@redhat.com>
References: <20260505065715.186759-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 7.0.y, thanks.

--
Sasha
