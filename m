Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F44921BC
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816519; cv=none; b=bGJ7ISqtLC6OvuC27R59AQgpeJZ2NnktQp4otYttiRtQwMTyaIn87xwOQA4vCpYWkSGUmcv/U6UyUBDUzKqmsgpzKovzORAimG6fVnI3Xga56OQbEFSM/YEAlcloJduDvXM/sCWgrWWA9EolPezvhtcGXbVcerVBU2asU6QS4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816519; c=relaxed/simple;
	bh=PMfChKFNMXJzKzjmxiF7G9lPkPYxthEBjqQbKUTksMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1pQ1hYhpV69Lq58kSuoEgoQyeIhq7sxUZeI8yIuK29mStKgN2iJHc3a8rbR8fZyCxMUm3t/E7Y2Q7zHtHGtvsEDgDFLAnJHNpU+BACPkqjie8zUdQAfEOaEyFGbCqRHcmmXrivTPmTZREK1jKSCdwjegeq+9URQI4t4hOzQ0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a18EyQSR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a18EyQSR"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337fb43c16so22311031cf.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791816517; x=1792421317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PMfChKFNMXJzKzjmxiF7G9lPkPYxthEBjqQbKUTksMA=;
        b=a18EyQSRv8P0iZVz2cFyE4nGgHoZsQEXyx8UJuHZjpdM+7Qf5SQhhP2xNWAH0VYzQf
         /hoTlApssge3VsQ/ughGQGY0EAl62gOiNulQUtPZtIib5tqYAnuOwBaIFP2jom9NqxZs
         Js7D3KhLF4ajJ3qghgQYaFLUYxdFUOYcU8NGDBSHwvQLHuHt9cmGCYRlNuetRRfZ8cBx
         q41L4B7/xbYzABJqwB1ksDueQgP+fEt/7CCxbNCqmetPUJk8paMF210jlmlyzh2TH+i0
         IYmXPXhqQploSSM8bOgX4etNpNXQAiPb3ki2WHim7bolH4+nLgdpLKyQW/5qIdwwO02t
         h5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816517; x=1792421317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PMfChKFNMXJzKzjmxiF7G9lPkPYxthEBjqQbKUTksMA=;
        b=y7akTvX1UfT7OW7JrIRFCU9h/fJQiU6emwoyw5VmGNNlCj/qGk29IoZeTdZrkh9pJB
         sYZaxmhrSPpRKczPNVM5sUehSaVHn+HbEJICjyEWhpFhE0G9Rs9UPGFoLyyWaSXKDTOb
         +P7U0CHC8t8gO174Dn2ydj1qN9GQNiiONCpNmoO8P0DzymuVWDdTiQ24zBm6FzBC7/Mx
         jf7z3KWBa48IuXVotJ3wBHDHyGjeJSbMDC/oHe+UoEdcowApNI3GRmRt0urahn+qGE+z
         pYeY7G9QifQWpG6kRF3izvxkPbzVPvpsKyQhhHa+G5fd74lpp0D76Zgt46BJlvVX+hgI
         7rDw==
X-Forwarded-Encrypted: i=1; AKwUvBwrbvkh/g6OQgUy8UFmf72F/JNfXxMbhnygU/P1WkAsaHyNmQD4Zrfr2cIFFGZW0TGgSJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/3mXuALBFpY7zIunXVUqzfHoFo9eyBy8pMjCbDiglYod69jMz
	oXTJRRFEM81p8kDxp0LvC5LkO6m0kSpFFxlCewci0YNGHXwSNYH0Bolo4/sNUReCHLA=
X-Gm-Gg: AYBFou1/0LvSvsJT2SOH+4nROM2NR7DToQp3YLSN9eL4pZESX7VkoFnWbsEJlMrdAbk
	rEaA7VcREKfJaP5FmfbAmIkaEFcGugQWGufGx34rNFVpEQGFKrE6FWi9j8xBtHu0tToM3TCmk2O
	WBERecpZxMMKuOv5SmDnlpvyi8fkfGkIbflujliNyIVJEkl7OgkAHRYWmCNhWsTCYommXc7gU2Y
	IIdgGQiPT6swB77hWj0NvKTnBitKhDPaE2SI307NtfIUpHTRYCWqFPNq97sX0emyfPje0hIJG6K
	e1Yl5JrojXf6hVwLIa/OPjeg8BLgIFqX5/o8EswDrcibyx6tzDV8Nol1PNn+dDmj3ujRfIeho2M
	Xusa8dN3teJFEMpX2J+BWdd+DGhiuB1hUWJhkgZYc2tXT4qESUa0Kw7WjFHQS4lQvyKJyrSEXqS
	TULtbU2uMl9P4W2R6+1YqPKCHwFWdVw0dLTqsaGT9WpzSTStkSG5OC/xcgPXfuz5q37nQE4VQC1
	UBybxm9sKye+ver7XTurOsi76XynNIKj3CV8trUhw==
X-Received: by 2002:a05:622a:4d93:b0:534:b7d1:cd1c with SMTP id d75a77b69052e-5359f498f75mr175097251cf.8.1791816516771;
        Mon, 12 Oct 2026 07:48:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa173sm80625631cf.7.2026.10.12.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:48:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGHKN-00000006Snm-0vE4;
	Mon, 12 Oct 2026 11:48:35 -0300
Date: Mon, 12 Oct 2026 11:48:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, alex@shazbot.org,
	bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
	mani@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
Message-ID: <20261012144835.GG14213@ziepe.ca>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <b1a3f755-19e3-407e-b8f8-b494de83f59a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a3f755-19e3-407e-b8f8-b494de83f59a@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 11:22:26AM -0700, Jeff Johnson wrote:

> Thank you for providing this level of detail in your cover letter. I've raised
> this issue with the engineering team in the past, but I've once again raised
> the issue with your in-depth analysis.

The main issue here is the driver can't use a normal MSI-X in the
normal MSI-X table.

"private" MSI registers don't work for virtualization.

Jason
