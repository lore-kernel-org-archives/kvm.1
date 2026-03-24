Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6403D34B9
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371962; cv=none; b=DVr7xoDqHuCp4ExWFmgPAenyaX3I1A8zg2B49r/vZ9TH1NhbT4DQM3V/SMU9PVm9UeYT2A6+vjEgQ2o+n5E/hzRfGfjQn9CWAb0I3B/2cddkFyrGYIaPSjDc1tq4XBle0m1odgBrEWyxP0qkoGD9f4fiu+jg1yxSqsQz7NT13E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371962; c=relaxed/simple;
	bh=5Sv9xAJZpaaT64nid3Je6B7u2J/2/RXvcmlIiaS9WJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjTU6+KMND49MN5b2Pamw9EA3iD3qeke0oOhsZqXZ7kbghF2AjKhgmxN7QtlD50ej6fcUQRXvdsCOwT8xjO69FqWuzEECr4BpQ99f1YxFcFwG9yIXZOttr+6ywuxhAO57exG32Lx30sCoxd/2D60wI46pZRgby8kgjjuiMIPi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+ocCLqH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+ocCLqH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so5524172a91.3
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774371961; x=1774976761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHY3J33g6ujwnRTqJrGO/jD1PTpcRqvXhZiCbNP/dps=;
        b=F+ocCLqHYAl+5Nc+4oVSi7m0MB45HhMwwGram+xxk+ok4l5Rgi55wO5VdXordRD9n3
         JqHAZNOJ3l5EmfJDXbH9R3Zs6GcE8DVzMsqQciMx5+ccLWQulqC51YKSLjC031syfrLR
         8LRl8tIr8z2MTLzw/wb7/S+QzhUNxoNYlb5k7OFDYTKid7ZJwMH0TxTrZ0uSf2U+HMDf
         eCpbLo1ex6VU/MjzjpkFwcn0kHW+nvSCnTZ2pfYPs3EjtXKvZDr6D5msjGik81+r2mtz
         zokKo3/2k5YytK/jpjzakodzAOIhLsQ8dJcPgCgHQU2kqCNu0fvm+zHQglERoWcLPK0b
         O7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371961; x=1774976761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHY3J33g6ujwnRTqJrGO/jD1PTpcRqvXhZiCbNP/dps=;
        b=le2He+XdFrt2uspcScXRzSmTA5eAcQkk47jvTBhkbarbuxuqeJH+zl9jxu8Ut5Tb/7
         40EviQ26+oRmWbthTo8QV7jSZd4cjwzAKK+T8IYbyViL5WGcB4Ri+Rrof9K9Tm12BY+j
         pVHmCUOgJW08PfuRMg0AOvV5qwf/37AHLY+AtCv0aA5AVEjZZyG6AtFh6+xmJD39/Dhc
         jFke9FmsSJsTFrLZ3MQNcGS8rsM/WaXS58fLvHyMOLWkQy0OPSOjZ5cf4rFiLiJUpGUP
         bactkz/FUf2JdhQyN3RRatI7UIYWatdwlxhEDNiEcfMpHv4EzMvykPUA5WWqiHJ8U4RK
         uQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3y/DCoyaeYIwitN4tvESQhY39gUOnGiozcn0i7hSwa2Go79qvV0h5pyseHOEAjHE1vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fpcYzRSVsvJpgMicsCJq1cDwZgF8aulfAWCe+hvkSARbDIB/
	MRfA0KrGhB9XN7eyhBpVO7xBDn476ZnJHNTbeDVuVsWoRjtpd5S8Ownnow1+ex9Ttw==
X-Gm-Gg: ATEYQzyBXz0ejw3Q4daqHo25VmwkvtxJawD5KcnGxEi++s88XwG6DU9UHRs6vf2X0Lx
	Ca/3eYXqKXXeDc5WOy4Q3A+FXap7fGpz/P7+Z78R4/90ZacZbIVbnRBxd6N7X2HH2HpVZs5HPkm
	N02KajC0FSWJ0KRPI/1WwU7ZHiPUhV3o1T8VfveevfWfeo3BOwvvszEdawXHi+u5++zgif5B4ch
	SXi4F2vlzYvVDZsmvtnoRzFPySD+M4kYVCStXQY4ZsTwn1uR54VyiW6a++XrqWKaHHGwbdeuFWF
	QDNoJZPrrLohylpJInzzFw1BlCYTHOEISVCPUrEVazeez+flUO/IPXBjjkqB4+r4sm0p/scbghK
	fBFjMDtecFAeB1zjWqjralrnSXKzxMHkDJlZxWMop25p96eS5R0RFUNClJkU66xVSNfam/vQdRS
	7nI8pHGe9KCmu7WeS9PFyN/8ZJIkst8KEXF6w8Y0ZWmKbeRdkZbFxqm4m8bfJpyw==
X-Received: by 2002:a17:90b:2249:b0:35b:a53a:7d0b with SMTP id 98e67ed59e1d1-35c0dd3ae00mr92968a91.20.1774371960194;
        Tue, 24 Mar 2026 10:06:00 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03172a8asm3524836a91.15.2026.03.24.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:05:59 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:05:55 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 08/24] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <acLEczJW3sGpeL5b@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-9-dmatlack@google.com>
 <815947ee-2603-47f0-9b03-f523601eae86@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815947ee-2603-47f0-9b03-f523601eae86@intel.com>

On 2026-03-24 09:08 PM, Yi Liu wrote:
> On 3/24/26 07:58, David Matlack wrote:
> > From: Vipin Sharma <vipinsh@google.com>
> > 
> > Enable userspace to retrieve preserved VFIO device files from VFIO after
> > a Live Update by implementing the retrieve() and finish() file handler
> > callbacks.
> > 
> > Use an anonymous inode when creating the file, since the retrieved
> > device file is not opened through any particular cdev inode, and the
> > cdev inode does not matter in practice.
> 
> do we have a list of struct file fields that do not matter?

My understanding is that VFIO only cares about these fields in struct
file:

 - private_data: Pointer to struct vfio_device_file
 - f_op: Pointer to vfio_device_fops
 - f_mapping: Pointer to vfio_device->inode->i_mapping

This is based on cross-referencing VFIO_GROUP_GET_DEVICE_FD (which uses
an anonymous inode) and the cdev code.

> > +err_free_device_file:
> > +	kvfree(df);
> 
> any reason to use kvfree()?

No this can be kfree(). Will fix in v4.
