Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1A23FC5A
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680372; cv=none; b=licGUHXuV95mX1vYbRglKGU688detR891lBEzdsuNaPKUajJPMAe1e/uSh7KQ19t7CaKK+7tQ/u3CBFgZ4PHNyHrHmIB+0RkgCumUqYTuCiuxGfGl86jcrL7UTDdnblHp9YgoeaDZ3KFhxrsVujUi9ckGBMbLFUnMIPuaO4Rwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680372; c=relaxed/simple;
	bh=KBh8K2+4xAoJb8QXNXariK4GLxraNCJrsAZVQUpEWnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJVaqf/PG6lQdS6ccdsYVnb0mWW9Hi0rx76WB31HE3PgiwtXZvaGNt8zBbFSVF5KPtdlsphDKFJUx+1Z6TerwjUUCB+c+OKXz+kgGNBBOI4yP4sKlkpiR7DNKwbn3GMFgei6mUmNaE3IMtk03q+iGL9JlsE1EsDbkzQwdl0UqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz6KvLGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz6KvLGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A915B1F00A3A;
	Fri, 10 Jul 2026 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680371;
	bh=rRoJTH88N6uaTEaTY9NQBN52SXwAuDUnA6uauekZCcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jz6KvLGa+F57kArfTA/Vvu8e32kz4GbvIMBg3OQ0DcJCIodaZ3u7WyEMmTw/mjS0X
	 UrjuIeJzcDcboDY+SqQHmA01JQQQ/RD17RyfQFTAUtez4M6EBVX1ujkPJVUOzP+ojL
	 8xDDfu65hUI2tZpHHs3kymPORtQEwxmBXThNfTWBwDSLpMcq85Qgvb96ED4E+xLAw8
	 I/uF+tHPtJZEWaz8XLKKq2mA5n0Ja6X96sOApkDDVoPCLDquM2Dp2oEbI+HwRdJSq7
	 cFEodo7/ah/htZUy3zq6S1BZN9i391wAMSgyN4+Hm5c9YJs+ePVgZ0c8NcHYmDt/Go
	 Ekzw+NhfVgy4Q==
Date: Fri, 10 Jul 2026 12:46:05 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	jpb@kernel.org, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
Message-ID: <alDNbZ4ZI34nPGKo@lpieralisi>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
 <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>

On Fri, Jul 10, 2026 at 11:09:43AM +1000, Gavin Shan wrote:

[...]

> After syncing the definitions with those in (v14) host series, I'm able to boot
> a simple realm guest (no virtio devices) with one warning.
> 
>   qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap

That's because we need to use the VM instance specific check extension
rather than the global one before trying to enable the cap.

It is harmless.

Lorenzo
